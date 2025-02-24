"""
An AutoGen AssistantAgent implementation
to fetch stock price trends for a given stock name.
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client
from tools.stock_price_trends import stock_price_trends_tool_agent

# Assistant Agent: Stock Price Trends
stock_price_trends_agent_assistant = AssistantAgent(
    name="stock_price_trends_agent",
    model_client=inference_model_client,
    tools=[stock_price_trends_tool_agent],
    system_message=(
        "You are the Stock Price Trends Agent. "
        "You fetch and summarize stock prices, "
        "changes over the last few months, and general market trends. "
        "Do NOT provide any final investment decision."
    )
)
