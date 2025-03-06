# Quick Start 3: Developing an AI Inference Chat Application with RAG using Azure AI Foundry

[English](./README.md) | [日本語](./README.ja.md)

In this note, we will explain how to develop a simple inference chat application using the Azure AI Foundry SDK with your own data for RAG (Retrieval-Augmented Generation).

We will pre-register a search index of sample data for fictional outdoor products using Azure AI Search. For user queries, we will retrieve documents with high similarity using the search index, and use the retrieved documents as grounding data to query the inference model along with the query to get an appropriate answer.

To retrieve documents with high similarity to the query, we will perform vector similarity search. We will vectorize the data to be pre-registered in the search index using an embedding model, and register the vectorized data in the search index as well. Similarly, for user queries, we will vectorize them and use Azure AI Search to search and retrieve documents.

[Jupyter Notebook (日本語)](./rag_chat.ipynb)
