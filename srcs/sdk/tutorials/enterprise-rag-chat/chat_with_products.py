"chat_with_product.py"

import os
from pathlib import Path

from azure.ai.inference.prompts import PromptTemplate
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential
from opentelemetry import trace
from config import ASSET_PATH, enable_telemetry, get_logger
from get_product_documents import get_product_documents, intent_mapping

# initialize logging and tracing objects
logger = get_logger(__name__)
tracer = trace.get_tracer(__name__)

# create a project client using environment variables loaded from the .env file
project = AIProjectClient.from_connection_string(
    conn_str=os.environ["PROJECT_CONNECTION_STRING"],
    credential=DefaultAzureCredential()
)

# create a chat client we can use for testing
chat = project.inference.get_chat_completions_client()

grounded_chat = Path(ASSET_PATH) / os.environ["GROUNDED_CHAT_PROMPT"]


@tracer.start_as_current_span(name="chat_with_products")
def chat_with_products(
    messages: list,
    context: dict = None
) -> dict:
    """Chat with products"""
    if context is None:
        context = {}

    documents = get_product_documents(messages, context)

    # do a grounded chat call using the search results
    # logger.info("Grounded Chat Prompty file  = %s", grounded_chat)
    grounded_chat_prompt = PromptTemplate.from_prompty(grounded_chat)

    system_message = grounded_chat_prompt.create_messages(
        documents=documents,
        context=context,
    )
    response = chat.complete(
        model=os.environ["CHAT_MODEL"],
        messages=system_message + messages,
        **grounded_chat_prompt.parameters,
    )
    logger.info("💬 Response: %s", response.choices[0].message)

    # Return a chat protocol compliant response
    return {"message": response.choices[0].message, "context": context}


if __name__ == "__main__":
    import argparse

    # load command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--query",
        type=str,
        help="Query to use to search product",
        default="I need a new tent for 4 people, what would you recommend?",
    )
    parser.add_argument(
        "--intent-mapping",
        type=str,
        help="path to propmty file for intent mapping",
        default=intent_mapping
    )
    parser.add_argument(
        "--grounded-chat",
        type=str,
        help="path to propmty file for grounded mapping",
        default=grounded_chat
    )
    parser.add_argument(
        "--enable-telemetry",
        action="store_true",
        help="Enable sending telemetry back to the project",
    )
    args = parser.parse_args()
    intent_mapping = Path(args.intent_mapping).resolve()
    grounded_chat = Path(args.grounded_chat).resolve()
    if args.enable_telemetry:
        enable_telemetry(True)

    # run chat with products
    res = chat_with_products(
        messages=[{"role": "user", "content": args.query}],
    )
