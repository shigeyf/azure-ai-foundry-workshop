"""Configuration for this application with Azure AI Agent Service."""

import os

from dotenv import load_dotenv

load_dotenv("./.env", verbose=True)

# Initialize environment variables
env_PROJECT_CONNECTION_STRING = os.getenv("PROJECT_CONNECTION_STRING")
env_PROJECT_API_KEY = os.getenv("PROJECT_API_KEY")

env_MODEL_NAME = os.getenv("MODEL_NAME")
env_INFERENCE_ENDPOINT = os.getenv("INFERENCE_ENDPOINT")
env_BING_CONNECTION_STRING = os.getenv("BING_CONNECTION_STRING")

env_AZURE_ENDPOINT = os.getenv("AZURE_ENDPOINT")
env_AZURE_DEPLOYMENT_NAME = os.getenv("AZURE_DEPLOYMENT_NAME")
env_MODEL_API_VERSION = os.getenv("MODEL_API_VERSION")
