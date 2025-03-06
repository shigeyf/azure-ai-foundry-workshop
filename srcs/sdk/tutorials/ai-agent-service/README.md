# Tutorial: Build a custom Agent app with a combination of Azure AI Agent Service and AutoGen

In this tutorial, you will learn how to build a custom agent app using Azure AI Agent Service and AutoGen. Azure AI Agent Service is a service for easily deploying and managing AI models, and AutoGen is a tool for quickly developing applications using auto-generated code. This combination allows you to efficiently build complex AI applications.

In this sample code, you will learn how to create a custom agent app by combining Azure AI Agent Service and AutoGen and apply it to real use cases. Through this tutorial, you will acquire efficient AI application development techniques using Azure AI Agent Service and AutoGen.

## Code Explanation

The code provided in this tutorial is a custom application that helps decide whether to invest in a specified stock (do not use this for actual investment decisions, no guarantees!).

The following agents gather information for making investment decisions, and an agent that makes the investment decision based on the gathered information. These agents are implemented using AutoGen's `AssistantAgent`. The entire process is automated using AutoGen's `RoundRobinGroupChat`, allowing it to be executed quickly and efficiently.

- [agents/stock_price_trends_agent.py](./agents/stock_price_trends_agent.py): An agent that collects information on the stock price trends of the specified stock.
- [agents/news_analysis_agent.py](./agents/news_analysis_agent.py): An agent that collects and analyzes news and latest information about the specified stock.
- [agents/stock_sentiment_agent.py](./agents/stock_sentiment_agent.py): An agent that collects information on market sentiment regarding the specified stock.
  - It gathers information based on market sentiment, analyst reports, and expert opinions.
- [agents/investment_decision_agent.py](./agents/investment_decision_agent.py): An agent that makes the investment decision by synthesizing the information from the above three agents.

These agents perform inference using the Azure model inference API client.

These `AssistantAgent` agents can be assigned tools, so we assign Azure AI Agent Service agents as tools.

In this sample code, the following Azure AI Agent Service tool agents are implemented. These agents use Bing grounding search tools to gather search results, which the LLM consolidates and returns to the `Assistant Agent` implementation:

- [tools/stock_price_trends.py](./tools/stock_price_trends.py): A tool to get stock price trends.
- [tools/news_analysis.py](./tools/news_analysis.py): A tool to get news and latest information.
- [tools/market_sentiment.py](./tools/market_sentiment.py): A tool to get market sentiment information.
- [tools/analyst_reports.py](./tools/analyst_reports.py): A tool to get analyst report information.
- [tools/expert_opinions.py](./tools/expert_opinions.py): A tool to get expert opinion information.

The system messages passed to each agent are defined in [`messages.py`](./messages.py).

The Azure AI Foundry SDK tools have tracing enabled in all these codes, so connect Application Insights in your Azure AI Foundry project to collect trace information.
