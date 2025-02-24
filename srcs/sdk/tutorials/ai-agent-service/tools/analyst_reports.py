"""
An AI Agent implementation to fetch analyst reports for a given stock name.
"""

from config import env_MODEL_NAME
from project import bing_connection, project_client
from tools.ai_agent_properties import AIAgentProperties
from tools.base_agent_with_bing import base_agent_with_bing


# Analyst Reports
async def analyst_reports_tool_agent(stock_name: str) -> str:
    """
    Agent function to fetch analyst reports for a given stock name.
    Args:
        stock_name: The name of the stock to fetch reports for.
        project_client: The AIProjectClient instance.
        model_name: The model name to use.
        bing_connection: The Bing connection properties.
    """
    agent_name = "analyst_reports_tool_agent"
    instructions = (
        f"Focus on any relevant analyst reports "
        f"or professional analysis about {stock_name}."
    )
    content = (
        f"Find recent analyst reports, price targets, "
        f"or professional opinions on {stock_name}."
    )
    print(
        f"[{agent_name}] "
        f"Fetching analyst reports for {stock_name}..."
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
