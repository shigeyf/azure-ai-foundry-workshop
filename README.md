# Azure AI Foundry Workshop: From Beginner to Intermediate

[English](./README.md) | [日本語](./README.ja.md)

This repository contains learning materials for developing and building your own AI applications on Azure using the Azure AI Foundry service.

Please open VSCode workspace [`default`](./default.code-workspace) file when you will learn on your local computer.

The workspace is organized into the following sections:

## Deployments

### Terraform

The `deployments/terraform` folder contains Terraform scripts to deploy Azure AI Foundry resources. Refer to the [README](./infra/terraform/README.md) in this folder for detailed instructions on deployment.

## SDK Quick-Starts

The `srcs/sdk/quick-starts` folder contains a series of quick-start examples to help you get started with Azure AI Foundry SDK to learn application development using the Azure AI Foundry SDK step-by-step with Jupyter Notebooks.

Each subfolder focuses on a specific use case:

- Learn sample application development with notebook
  - Includes the following:
    - [0. Basics of Azure AI Foundry](./srcs/sdk/quick-starts/00_basics/)
      - Basic examples to understand the SDK's core functionalities.
    - [1. Building a Simple AI Inference Chat Application with Azure AI Foundry](./srcs/sdk/quick-starts/01_simple_inference_chat/)
      - Demonstrates simple inference chat capabilities.
    - [2. Building a Simple AI Inference Chat Application with Azure AI Foundry (Continued)](./srcs/sdk/quick-starts/02_simple_chat_with_prompt_template/)
      - Shows how to use prompt templates for chat interactions.
    - [3. Developing an AI Inference Chat Application with RAG using Azure AI Foundry](./srcs/sdk/quick-starts/03_rag_chat/)
      - Implements Retrieval-Augmented Generation (RAG) for chat applications.
    - [4. Developing an Application to Evaluate Inference Model Results with Azure AI Foundry](./srcs/sdk/quick-starts/04_evaluation/)
      - Examples for evaluating AI models and their outputs.
    - [5. Developing a Simple AI Agent Application with Azure AI Foundry](./srcs/sdk/quick-starts/05_simple_agent/)
      - Demonstrates building a simple AI agent.

## SDK Tutorials

The `srcs/sdk/tutorials` folder contains more comprehensive tutorials for advanced use cases:

- Build sample applications with modular code
- Includes the following:
  1. [Building a Custom RAG Chat App with the Azure AI Foundry SDK](./srcs/sdk/tutorials/enterprise-rag-chat/)
     - A tutorial on building an enterprise-grade RAG chat application.
  1. [Building a Custom Agent App with a Combination of Azure AI Agent Service and AutoGen](./srcs/sdk/tutorials/ai-agent-service/)
     - Explains how to create an AI agent service.

## Getting Started

1. Clone this repository.
2. Follow the instructions in the respective folders to set up and run the examples or tutorials.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any suggestions or improvements.
