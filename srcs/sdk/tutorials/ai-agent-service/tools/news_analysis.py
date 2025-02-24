"""
An AI Agent implementation to fetch news analysis for a given stock name.
"""

from config import env_MODEL_NAME
from project import bing_connection, project_client
from tools.ai_agent_properties import AIAgentProperties
from tools.base_agent_with_bing import base_agent_with_bing


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
    agent_name = "news_analysis_tool_agent"
    instructions = (
        f"Focus on the latest news highlights for stock {stock_name}."
    )
    content = (
        f"Retrieve the latest news articles and summaries "
        f"about {stock_name}."
    )
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
