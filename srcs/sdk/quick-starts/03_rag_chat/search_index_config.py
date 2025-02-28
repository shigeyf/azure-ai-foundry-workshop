"""
The configuration for Azure AI Search search index.
"""

from azure.search.documents.indexes.models import (
  ExhaustiveKnnAlgorithmConfiguration, ExhaustiveKnnParameters,
  HnswAlgorithmConfiguration, HnswParameters,
  SemanticConfiguration, SemanticField,
  SemanticPrioritizedFields, SemanticSearch,
  VectorSearch, VectorSearchProfile,
  VectorSearchAlgorithmKind, VectorSearchAlgorithmMetric,
)


#
# For Semantioc Search:
#

# The "content" field should be prioritized for semantic ranking.
semantic_config = SemanticConfiguration(
    name="default",
    prioritized_fields=SemanticPrioritizedFields(
        title_field=SemanticField(field_name="title"),
        keywords_fields=[],
        content_fields=[SemanticField(field_name="content")],
    ),
)

# Create the semantic settings with the configuration
semantic_search = SemanticSearch(configurations=[semantic_config])


#
# For Vector Search:
#

# We want to use the HNSW (Hierarchical Navigable Small World) algorithm
# (a type of approximate nearest neighbor search algorithm)
# with cosine distance.
vector_algorithm = [
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
            metric=VectorSearchAlgorithmMetric.COSINE
        ),
    ),
]

vector_profile = [
    VectorSearchProfile(
        name="myHnswProfile",
        algorithm_configuration_name="myHnsw",
    ),
    VectorSearchProfile(
        name="myExhaustiveKnnProfile",
        algorithm_configuration_name="myExhaustiveKnn",
    ),
]

# For vector search, we want to use
# the HNSW (Hierarchical Navigable Small World) algorithm
# (a type of approximate nearest neighbor search algorithm)
# with cosine distance.
vector_search = VectorSearch(
    algorithms=vector_algorithm,
    profiles=vector_profile,
)
