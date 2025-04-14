"""
An AI Agent implementation to fetch news analysis for a given stock name.
"""

from opentelemetry import trace

from config import env_MODEL_NAME
from project import bing_connection, project_client, tracer
from tools.ai_agent_properties import AIAgentProperties
from tools.base_agent_with_bing import base_agent_with_bing
from messages_ja import (
  news_analysis_tool_instructions,
  news_analysis_tool_content,
)


# Agent Tool: News Analysis
async def news_analysis_tool_agent(stock_name: str) -> str:
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
        "news_analysis_tool_agent",
        context=trace.set_span_in_context(currspan),
    ):
        agent_name = "news_analysis_tool_agent"
        instructions = news_analysis_tool_instructions.format(stock_name=stock_name)
        content = news_analysis_tool_content.format(stock_name=stock_name)
        print(
            f"[{agent_name}] "
            f"Fetching news analysis for {stock_name}..."
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
