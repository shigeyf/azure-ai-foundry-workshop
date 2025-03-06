# Quick Start 5: Developing a Simple AI Agent Application with Azure AI Foundry

[English](./README.md) | [日本語](./README.ja.md)

In this note, we will explain how to develop an inference chat application using an AI agent with the Azure AI Foundry SDK.

Azure AI Foundry provides a platform called Azure AI Agent Service to run agents. Azure AI Agent Service is a fully managed service designed to build, deploy, and scale high-quality, scalable AI agents securely without developers needing to manage the computing and storage resources required to run the agents.

In traditional AI applications, hundreds of lines of code were required to support client-side function calls, but with Azure AI Agent Service, this can be done with just a few lines of code.

AI Agent Service allows you to assign various tools to run agents using inference models.

- Knowledge Tools
  - Grounding using Bing Search ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/bing-grounding?tabs=python&pivots=code-example))
  - File Search ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/file-search?tabs=python&pivots=azure-blob-storage-code-examples))
  - Azure AI Search ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/azure-ai-search?tabs=azurecli%2Cpython&pivots=code-examples))
- Action Tools
  - Code Interpreter ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/code-interpreter?tabs=python&pivots=overview))
  - Custom Functions ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/function-calling?tabs=python&pivots=code-example))
  - Azure Functions ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/azure-functions?pivots=code-example))
  - API Tools defined with OpenAPI ([Code Example](https://learn.microsoft.com/azure/ai-services/agents/how-to/tools/openapi-spec?tabs=python&pivots=code-example))

> **Note**
> The OpenAI models supported for "Grounding using Bing Search" are:
> gpt-3.5-turbo-0125, gpt-4-0125-preview, gpt-4-turbo-2024-04-09, gpt-4o-0513

The following notes are available:

- [Agent using the Code Interpreter tool (日本語)](./agent_chat.ipynb)
- [Agent using the Azure AI Search tool (日本語)](./agent_chat_aisearch.ipynb)
- [Agent using the OpenAPI tool (日本語)](./agent_chat_openapi.ipynb)
