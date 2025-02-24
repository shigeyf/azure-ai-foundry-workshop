"evaluate.py"

import os
import time
from pathlib import Path

import pandas as pd
from azure.ai.evaluation import GroundednessEvaluator, evaluate
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import ConnectionType
from azure.identity import DefaultAzureCredential
from dotenv import load_dotenv
from chat_with_products import chat_with_products
from config import EVAL_PATH, get_logger

# initialize logging and tracing objects
logger = get_logger(__name__)

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

eval_data = Path(EVAL_PATH) / os.environ["EVALUATION_DATA"]

groundedness = GroundednessEvaluator(evaluator_model)


def evaluate_chat_with_products(query):
    """Evaluate the chat_with_products function with a query."""
    response = chat_with_products(
        messages=[{"role": "user", "content": query}],
    )
    return {
        "response": response["message"].content,
        "context": response["context"]["grounding_data"]
    }


# Evaluate must be called inside of __main__, not on import
if __name__ == "__main__":
    import contextlib
    import multiprocessing
    # workaround for multiprocessing issue on linux
    from pprint import pprint

    with contextlib.suppress(RuntimeError):
        multiprocessing.set_start_method("spawn", force=True)

    # logger.info("Evaluation data file = %s", eval_data)

    # run evaluation with a dataset and target function, log to the project
    result = evaluate(
        data=eval_data,
        target=evaluate_chat_with_products,
        evaluation_name=f"evaluate_chat_with_products-{time.strftime("%Y%m%d%H%M%S")}",
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
        output_path=f"./myevalresults-{time.strftime("%Y%m%d%H%M%S")}.json",
    )

    tabular_result = pd.DataFrame(result.get("rows"))

    pprint("-----Summarized Metrics-----")
    pprint(result["metrics"])
    pprint("-----Tabular Result-----")
    pprint(tabular_result)
    pprint(f"View evaluation results in AI Studio: {result['studio_url']}")
