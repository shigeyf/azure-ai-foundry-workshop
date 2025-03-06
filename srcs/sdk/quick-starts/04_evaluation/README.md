# Quick Start 4: Developing an Application to Evaluate Inference Model Results with Azure AI Foundry

[English](./README.md) | [日本語](./README.ja.md)

In this note, we will explain how to develop an application to evaluate queries and results of a chat application using an inference model with the Azure AI Foundry SDK.

AI evaluation is an essential element of the lifecycle of generative AI applications to maximize the impact of AI application deployment and build trust and credibility in AI utilization in business. If an AI application generates outputs that are out of context, irrelevant, inconsistent, or fabricated, it can result in a poor application experience, decisions based on incorrect information, exposure to malicious attacks, and various other negative impacts. Therefore, quality and reliability evaluation of AI applications is crucial.

We will develop the evaluation application using the `azure.ai.projects` and `azure.ai.evaluation` libraries. The application developed here will upload a pre-prepared evaluation dataset and perform evaluations in the cloud (remotely). Evaluations can also be performed locally.

[Jupyter Notebook (日本語)](./eval.ipynb)
