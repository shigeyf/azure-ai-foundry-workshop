"""
An AutoGen AssistantAgent implementation
to fetch stock price trends for a given stock name.
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client
from tools.stock_price_trends import stock_price_trends_tool_agent
from messages_ja import stock_price_trends_system_message
from project import tracer


# Assistant Agent: Stock Price Trends
with tracer.start_as_current_span("stock_price_trends_agent"):
  stock_price_trends_agent_assistant = AssistantAgent(
      name="stock_price_trends_agent",
      model_client=inference_model_client,
      tools=[stock_price_trends_tool_agent],
      system_message=stock_price_trends_system_message,
  )
