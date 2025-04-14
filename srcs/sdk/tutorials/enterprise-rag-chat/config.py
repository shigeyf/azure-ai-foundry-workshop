"config.py"

import logging
import os
import pathlib
import sys
import time

from azure.ai.inference.tracing import AIInferenceInstrumentor
from azure.ai.projects import AIProjectClient
from azure.core.settings import settings
from azure.identity import DefaultAzureCredential
from azure.monitor.opentelemetry import configure_azure_monitor
from dotenv import load_dotenv
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider

# load environment variables from the .env file at the root of this repo
load_dotenv('./.env', override=True)

# Set "./assets" as the path where assets are stored,
# resolving the absolute path:
ASSET_PATH = pathlib.Path(__file__).parent.resolve() / "assets"

# Set "./tests" as the path where evaluation contents are stored,
# resolving the absolute path:
EVAL_PATH = pathlib.Path(__file__).parent.resolve() / "tests"

# Configure an root app logger that prints info level logs to stdout
logger = logging.getLogger("app")
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler(stream=sys.stdout))

# Configure the OpenTelemetry tracer
tracer_scenario = f"Trace: tutorial-rag-chat-{time.time()}"
tracer = trace.get_tracer(__name__)


# Returns a module-specific logger, inheriting from the root app logger
def get_logger(module_name):
    """Returns a module-specific logger, inheriting from the root app logger"""
    return logging.getLogger(f"app.{module_name}")


# Enable instrumentation and logging of telemetry to the project
def enable_telemetry(log_to_project: bool = False):
    """Enables telemetry logging to the project and/or application insights"""

    # Enable Azure SDK tracing with either of two lines:
    os.environ["AZURE_SDK_TRACING_IMPLEMENTATION"] = "opentelemetry"
    settings.tracing_implementation = "opentelemetry"

    # Enable logging message contents
    os.environ["AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED"] = "true" # Enable content recording
    # Enable Azure AI Foundry tracing (Model Inference API)
    AIInferenceInstrumentor().instrument()

    if log_to_project:
        project = AIProjectClient.from_connection_string(
            conn_str=os.environ["PROJECT_CONNECTION_STRING"],
            credential=DefaultAzureCredential()
        )

        tracing_link = (
            f"https://ai.azure.com/tracing?wsid="
            f"/subscriptions/{project.scope['subscription_id']}"
            f"/resourceGroups/{project.scope['resource_group_name']}"
            f"/providers/Microsoft.MachineLearningServices"
            f"/workspaces/{project.scope['project_name']}"
        )

        application_insights_connection_string = (
            project.telemetry.get_connection_string()
        )
        if not application_insights_connection_string:
            logger.warning(
                """No application insights configured,
                  telemetry will not be logged to project.
                  Add application insights at:"""
            )
            logger.warning(tracing_link)

            return

        configure_azure_monitor(
            connection_string=application_insights_connection_string
        )
        project.telemetry.enable()
        logger.info("Enabled telemetry logging to project, view traces at:")
        logger.info(tracing_link)
