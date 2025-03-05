"""
An AutoGen AssistantAgent implementation
to fetch news analysis for a given stock name.
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client
from tools.news_analysis import news_analysis_tool_agent
from messages_ja import news_analysis_agent_system_message
from project import tracer


# Assistant Agent: News Analysis
with tracer.start_as_current_span("tutorials: ai-agent-service[news_analysis_agent]"):
  news_analysis_agent_assistant = AssistantAgent(
      name="stock_news_analysis_agent_assistant",
      model_client=inference_model_client,
      tools=[news_analysis_tool_agent],
      system_message=news_analysis_agent_system_message,
  )
