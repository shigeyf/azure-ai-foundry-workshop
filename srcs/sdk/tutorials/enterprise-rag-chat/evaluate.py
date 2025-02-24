"evaluate.py"

import os

import pandas as pd
from azure.ai.evaluation import GroundednessEvaluator, evaluate
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import ConnectionType
from azure.identity import DefaultAzureCredential
from dotenv import load_dotenv
from chat_with_products import chat_with_products

# load environment variables from the .env file at the root of this repo
load_dotenv('./.env', override=True)

# create a project client using environment variables loaded from the .env file
project = AIProjectClient.from_connection_string(
    conn_str=os.environ["PROJECT_CONNECTION_STRING"],
    credential=DefaultAzureCredential()
)

connection = project.connections.get_default(
    connection_type=ConnectionType.AZURE_OPEN_AI, include_credentials=True)

evaluator_model = {
    "azure_endpoint": connection.endpoint_url,
    "azure_deployment": os.environ["EVALUATION_MODEL"],
    "api_version": "2024-06-01",
    "api_key": connection.key,
}

groundedness = GroundednessEvaluator(evaluator_model)


def evaluate_chat_with_products(query):
    """Evaluate the chat_with_products function with a query."""
    response = chat_with_products(
        messages=[{"role": "user", "content": query}])
    return {
        "response": response["message"].content,
        "context": response["context"]["grounding_data"]
    }


# Evaluate must be called inside of __main__, not on import
if __name__ == "__main__":
    import contextlib
    import multiprocessing
    from pathlib import Path
    # workaround for multiprocessing issue on linux
    from pprint import pprint

    from config import EVAL_PATH

    with contextlib.suppress(RuntimeError):
        multiprocessing.set_start_method("spawn", force=True)

    # run evaluation with a dataset and target function, log to the project
    # TODO:
    result = evaluate(
        data=Path(EVAL_PATH) / "chat_eval_data.ja.jsonl",
        target=evaluate_chat_with_products,
        evaluation_name="evaluate_chat_with_products",
        evaluators={
            "groundedness": groundedness,
        },
        evaluator_config={
            "default": {
                "query": {"${data.query}"},
                "response": {"${target.response}"},
                "context": {"${target.context}"},
            }
        },
        azure_ai_project=project.scope,
        output_path="./myevalresults.json",
    )

    tabular_result = pd.DataFrame(result.get("rows"))

    pprint("-----Summarized Metrics-----")
    pprint(result["metrics"])
    pprint("-----Tabular Result-----")
    pprint(tabular_result)
    pprint(f"View evaluation results in AI Studio: {result['studio_url']}")
