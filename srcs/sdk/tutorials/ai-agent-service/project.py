"""
AI client instances for Azure AI Agent Service.
This example uses the Azure AI Agent Service and the Bing Grounding Tool.
"""

import re

from autogen_core.models import ModelFamily
from autogen_ext.models.azure import AzureAIChatCompletionClient
from autogen_ext.models.openai import AzureOpenAIChatCompletionClient
from azure.ai.projects import AIProjectClient
from azure.core.credentials import AzureKeyCredential
from azure.identity import DefaultAzureCredential
from config import (env_AZURE_DEPLOYMENT_NAME, env_AZURE_ENDPOINT,
                    env_BING_CONNECTION_STRING, env_INFERENCE_ENDPOINT,
                    env_MODEL_API_VERSION, env_MODEL_NAME, env_PROJECT_API_KEY,
                    env_PROJECT_CONNECTION_STRING)


# Regex Mapping of Gen AI model name to AutoGen Core ModelFamily
def get_model_family(model_name):
    """Get the model family based on the model name."""
    for pattern, family in model_family_mapping.items():
        if re.match(pattern, model_name, re.IGNORECASE):
            return family
    return ModelFamily.UNKNOWN


# An array for mapping of Gen AI model name to AutoGen Core ModelFamily
# You can freely add the mappings here.
model_family_mapping = {
    "gpt-4o": ModelFamily.GPT_4O,
    "gpt-4o-mini": ModelFamily.GPT_4O,
    "gpt-4": ModelFamily.GPT_4,
    "gpt-3.5-turbo": ModelFamily.GPT_35,
}

# Azure AI Foundry Project Client
project_client = AIProjectClient.from_connection_string(
    conn_str=env_PROJECT_CONNECTION_STRING,
    credential=DefaultAzureCredential(),
)

# Azure AI Model Client under AutoGen API
inference_model_client = AzureAIChatCompletionClient(
    model=env_MODEL_NAME,
    endpoint=env_INFERENCE_ENDPOINT,
    credential=AzureKeyCredential(env_PROJECT_API_KEY),
    model_info={
        "json_output": True,
        "function_calling": True,
        "vision": False,
        "family": get_model_family(env_MODEL_NAME.lower()),
    },
)

# Azure OpenAI Client
az_model_client = AzureOpenAIChatCompletionClient(
    azure_deployment=env_AZURE_DEPLOYMENT_NAME,
    model=env_MODEL_NAME,
    api_key=env_PROJECT_API_KEY,
    api_version=env_MODEL_API_VERSION,
    azure_endpoint=env_AZURE_ENDPOINT,
)

# Retrieve the Bing connection
bing_connection = project_client.connections.get(
    connection_name=env_BING_CONNECTION_STRING
)
