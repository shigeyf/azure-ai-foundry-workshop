# Tutorial: Build a custom RAG chat app with Azure AI Foundry SDK

[English](./README.md) | [日本語](./README.ja.md)

In this tutorial, you use the Azure AI Foundry SDK (and other libraries) to build, configure, and evaluate a chat app for your retail company called Contoso Trek. Your retail company specializes in outdoor camping gear and clothing. The chat app should answer questions about your products and services. For example, the chat app can answer questions such as "which tent is the most waterproof?" or "what is the best sleeping bag for cold weather?".

This tutorial is an in-depth tutorial which is introduced in the following Microsoft Learn documentations. Part 1 is not covered by this tutorial. Please follow the document to setup your environment.

- [Part 1 - Set up project and development environment to build a custom knowledge retrieval (RAG) app with the Azure AI Foundry SDK](https://learn.microsoft.com/en-us/azure/ai-foundry/tutorials/copilot-sdk-create-resources?tabs=windows)
  - Create a project
  - Create an Azure AI Search index
  - Install the Azure CLI and sign in
  - Install Python and packages
  - Deploy models into your project
  - Configure your environment variables

> If you've completed other tutorials or quickstarts, you might have already created some of the resources needed for this tutorial. If you have, feel free to skip those steps here.

- [Part 2 - Build a custom knowledge retrieval (RAG) app with the Azure AI Foundry SDK](https://learn.microsoft.com/en-us/azure/ai-foundry/tutorials/copilot-sdk-build-rag)

  - Get example data
  - Create a search index of the data for the chat app to use
  - Develop custom RAG code

- [Part 3 - Evaluate a custom chat application with the Azure AI Foundry SDK](https://learn.microsoft.com/en-us/azure/ai-foundry/tutorials/copilot-sdk-evaluate)
  - Create an evaluation dataset
  - Evaluate the chat app with Azure AI evaluators
  - Iterate and improve your app

The environment variables used in this project are as follows:

```text
PROJECT_CONNECTION_STRING=<your-project-connection-string>
SEARCH_INDEX_NAME="example-index"
EMBEDDINGS_MODEL="text-embedding-ada-002"
INTENT_MAPPING_MODEL="gpt-4o-mini"
CHAT_MODEL="gpt-4o-mini"
EVALUATION_MODEL="gpt-4o-mini"
INTENT_MAPPING_PROMPT="intent_mapping.prompty"
GROUNDED_CHAT_PROMPT="grounded_chat.prompty"
EVALUATION_DATA="chat_eval_data.jsonl"
PRODUCT_INFO_FOLDER="product-info"
```
