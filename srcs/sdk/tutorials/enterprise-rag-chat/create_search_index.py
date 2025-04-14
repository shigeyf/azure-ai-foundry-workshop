"create_search_index.py"

import os
from pathlib import Path

import pandas as pd
from opentelemetry import trace
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import ConnectionType
from azure.core.credentials import AzureKeyCredential
from azure.identity import DefaultAzureCredential
from azure.search.documents import SearchClient
from azure.search.documents.indexes import SearchIndexClient
from azure.search.documents.indexes.models import (
  ExhaustiveKnnAlgorithmConfiguration, ExhaustiveKnnParameters,
  HnswAlgorithmConfiguration, HnswParameters, SearchableField, SearchField,
  SearchFieldDataType, SearchIndex, SemanticConfiguration, SemanticField,
  SemanticPrioritizedFields, SemanticSearch, SimpleField, VectorSearch,
  VectorSearchAlgorithmKind, VectorSearchAlgorithmMetric, VectorSearchProfile)

from config import ASSET_PATH
from config import get_logger
from config import enable_telemetry, tracer, tracer_scenario

# initialize logging object
logger = get_logger(__name__)

# create a project client using environment variables loaded from the .env file
project = AIProjectClient.from_connection_string(
    conn_str=os.environ["PROJECT_CONNECTION_STRING"],
    credential=DefaultAzureCredential()
)

# create a vector embeddings client
# that will be used to generate vector embeddings
embeddings = project.inference.get_embeddings_client()

# use the project client to get the default search connection
search_connection = project.connections.get_default(
    connection_type=ConnectionType.AZURE_AI_SEARCH, include_credentials=True
)

# Create a search index client using the search connection
# This client will be used to create and delete search indexes
index_client = SearchIndexClient(
    endpoint=search_connection.endpoint_url,
    credential=AzureKeyCredential(key=search_connection.key)
)


def create_index_definition(index_name: str, model: str) -> SearchIndex:
    """Creates a search index definition"""
    dimensions = 1536  # text-embedding-ada-002
    if model == "text-embedding-3-large":
        dimensions = 3072

    # The fields we want to index.
    # The "embedding" field is a vector field that will
    # be used for vector search.
    fields = [
        SimpleField(name="id", type=SearchFieldDataType.String, key=True),
        SearchableField(name="content", type=SearchFieldDataType.String),
        SimpleField(name="filepath", type=SearchFieldDataType.String),
        SearchableField(name="title", type=SearchFieldDataType.String),
        SimpleField(name="url", type=SearchFieldDataType.String),
        SearchField(
            name="contentVector",
            type=SearchFieldDataType.Collection(SearchFieldDataType.Single),
            searchable=True,
            # Size of the vector created by the text-embedding-ada-002 model.
            vector_search_dimensions=dimensions,
            vector_search_profile_name="myHnswProfile",
        ),
    ]

    # The "content" field should be prioritized for semantic ranking.
    semantic_config = SemanticConfiguration(
        name="default",
        prioritized_fields=SemanticPrioritizedFields(
            title_field=SemanticField(field_name="title"),
            keywords_fields=[],
            content_fields=[SemanticField(field_name="content")],
        ),
    )

    # For vector search, we want to use
    # the HNSW (Hierarchical Navigable Small World) algorithm
    # (a type of approximate nearest neighbor search algorithm)
    # with cosine distance.
    vector_search = VectorSearch(
        algorithms=[
            HnswAlgorithmConfiguration(
                name="myHnsw",
                kind=VectorSearchAlgorithmKind.HNSW,
                parameters=HnswParameters(
                    m=4,
                    ef_construction=1000,
                    ef_search=1000,
                    metric=VectorSearchAlgorithmMetric.COSINE,
                ),
            ),
            ExhaustiveKnnAlgorithmConfiguration(
                name="myExhaustiveKnn",
                kind=VectorSearchAlgorithmKind.EXHAUSTIVE_KNN,
                parameters=ExhaustiveKnnParameters(
                    metric=VectorSearchAlgorithmMetric.COSINE),
            ),
        ],
        profiles=[
            VectorSearchProfile(
                name="myHnswProfile",
                algorithm_configuration_name="myHnsw",
            ),
            VectorSearchProfile(
                name="myExhaustiveKnnProfile",
                algorithm_configuration_name="myExhaustiveKnn",
            ),
        ],
    )

    # Create the semantic settings with the configuration
    semantic_search = SemanticSearch(configurations=[semantic_config])

    # Create the search index definition
    return SearchIndex(
        name=index_name,
        fields=fields,
        semantic_search=semantic_search,
        vector_search=vector_search,
    )

# define a function for indexing a csv file, that adds each row as a document
# and generates vector embeddings for the specified content_column


def create_docs_from_csv(
  use_product_info: bool,
  path: str, content_column: str, model: str
) -> list[dict[str, any]]:
    """Creates documents from a CSV file,
      generating vector embeddings for the specified content column"""
    products = pd.read_csv(path)
    items = []
    for product in products.to_dict("records"):
        content = product[content_column]
        pid = str(product["id"])

        if use_product_info:
            product_info_folder = os.environ["PRODUCT_INFO_FOLDER"]
            product_info_file = f"product_info_{pid}.md"
            product_file = (
                Path(ASSET_PATH) / product_info_folder / product_info_file
            )
            try:
                with open(product_file, "r", encoding="utf-8") as file:
                    content = file.read()
            # pylint: disable=broad-exception-caught
            except Exception:
                pass

        title = product["name"]
        url = f"/products/{title.lower().replace(' ', '-')}"
        emb = embeddings.embed(input=content, model=model)
        rec = {
            "id": pid,
            "content": content,
            "filepath": f"{title.lower().replace(' ', '-')}",
            "title": title,
            "url": url,
            "contentVector": emb.data[0].embedding,
        }
        items.append(rec)

    return items


def create_index_from_csv(index_name, csv_file, use_product_info):
    """Creates a search index from a CSV file,
      generating vector embeddings for the specified content column"""
    # If a search index already exists, delete it:
    try:
        index_definition = index_client.get_index(index_name)
        index_client.delete_index(index_name)
        logger.info(
            "🗑️  Found existing index named '%s', and deleted it", index_name)
    # pylint: disable=broad-exception-caught
    except Exception:
        pass

    # create an empty search index
    index_definition = create_index_definition(
        index_name, model=os.environ["EMBEDDINGS_MODEL"]
    )
    index_client.create_index(index_definition)

    # create documents from the products.csv file,
    # generating vector embeddings for the "description" column
    docs = create_docs_from_csv(
        use_product_info=use_product_info,
        path=csv_file, content_column="description",
        model=os.environ["EMBEDDINGS_MODEL"]
    )

    # Add the documents to the index using the Azure AI Search client
    search_client = SearchClient(
        endpoint=search_connection.endpoint_url,
        index_name=index_name,
        credential=AzureKeyCredential(key=search_connection.key),
    )

    search_client.upload_documents(docs)
    logger.info("➕ Uploaded %d documents to '%s' index", len(docs), index_name)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--index-name",
        type=str,
        help="index name to use when creating the AI Search index",
        default=os.environ["SEARCH_INDEX_NAME"],
    )
    parser.add_argument(
        "--csv-file",
        type=str,
        help="path to data for creating search index",
        default="assets/products.csv"
    )
    parser.add_argument(
        "--use-product-info",
        type=bool,
        help="whether to use product info markdown files as contents",
        default=False
    )
    parser.add_argument(
        "--enable-telemetry",
        action="store_true",
        help="Enable sending telemetry back to the project",
    )
    args = parser.parse_args()
    if args.enable_telemetry:
        enable_telemetry(True)

    with tracer.start_as_current_span(tracer_scenario) as top_span:
        with tracer.start_as_current_span(
          "create_index_from_csv",
          context=trace.set_span_in_context(top_span)
        ) as span:
            create_index_from_csv(args.index_name, args.csv_file, args.use_product_info)
