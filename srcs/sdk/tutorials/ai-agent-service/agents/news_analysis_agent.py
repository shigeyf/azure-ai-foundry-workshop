"""
An AutoGen AssistantAgent implementation
to fetch news analysis for a given stock name.
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client
from tools.news_analysis import news_analysis_tool_agent

# Assistant Agent: News Analysis
news_analysis_agent_assistant = AssistantAgent(
    name="stock_news_analysis_agent_assistant",
    model_client=inference_model_client,
    tools=[news_analysis_tool_agent],
    system_message=(
        "You are the News Agent. "
        "You retrieve and summarize the latest news stories "
        "related to the given stock. "
        "Do NOT provide any final investment decision."
    )
)
