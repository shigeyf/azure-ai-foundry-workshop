"""
An AutoGen AssistantAgent implementation
to fetch market sentiment for a give stock name.
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client
from tools.analyst_reports import analyst_reports_tool_agent
from tools.expert_opinions import expert_opinions_tool_agent
from tools.market_sentiment import market_sentiment_tool_agent
from messages_ja import stock_sentiment_system_message


# Assistant Agent: Stock Sentiment
stock_sentiment_agent_assistant = AssistantAgent(
    name="stock_sentiment_agent",
    model_client=inference_model_client,
    tools=[
        market_sentiment_tool_agent,
        analyst_reports_tool_agent,
        expert_opinions_tool_agent,
    ],
    system_message=stock_sentiment_system_message,
)
