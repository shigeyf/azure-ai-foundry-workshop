"""
An AI Agent implementation to fetch stock price trends for a given stock name.
"""

from opentelemetry import trace

from config import env_MODEL_NAME
from project import bing_connection, project_client, tracer
from tools.ai_agent_properties import AIAgentProperties
from tools.base_agent_with_bing import base_agent_with_bing
from messages_ja import (
  stock_price_trends_tool_instructions,
  stock_price_trends_tool_content,
)

# Agent Tool: Stock Price Trends
async def stock_price_trends_tool_agent(stock_name: str) -> str:
    """
    Agent function to retrieve the latest news articles and summaries
    for a given stock name.
    Args:
        stock_name: The name of the stock to fetch reports for.
        project_client: The AIProjectClient instance.
        model_name: The model name to use.
        bing_connection: The Bing connection properties.
    """
    currspan = trace.get_current_span()
    with tracer.start_as_current_span(
        "stock_price_trends_tool_agent",
        context=trace.set_span_in_context(currspan),
    ):
        agent_name = "stock_price_trends_tool_agent"
        instructions = stock_price_trends_tool_instructions.format(stock_name=stock_name)
        content = stock_price_trends_tool_content.format(stock_name=stock_name)
        print(
            f"[{agent_name}] "
            f"Fetching stock price trends for {stock_name}..."
        )

        return await base_agent_with_bing(
            project_client=project_client,
            model_name=env_MODEL_NAME,
            agent_properties=AIAgentProperties(
                agent_name=agent_name,
                instructions=instructions,
                content=content,
            ),
            bing_connection=bing_connection,
        )
