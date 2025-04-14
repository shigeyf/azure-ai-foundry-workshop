"""
An AutoGen AssistantAgent implementation
to fetch news analysis for a given stock name.
"""

from autogen_agentchat.agents import AssistantAgent
from opentelemetry import trace

from project import inference_model_client
from tools.news_analysis import news_analysis_tool_agent
from messages_ja import news_analysis_agent_system_message


# Assistant Agent: News Analysis
news_analysis_agent_assistant = AssistantAgent(
    name="stock_news_analysis_agent_assistant",
    model_client=inference_model_client,
    tools=[news_analysis_tool_agent],
    system_message=news_analysis_agent_system_message,
)
