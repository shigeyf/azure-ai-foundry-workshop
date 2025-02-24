"""
An AI Agent implementation to fetch expert opinions for a given stock name.
"""

from config import env_MODEL_NAME
from project import bing_connection, project_client
from tools.ai_agent_properties import AIAgentProperties
from tools.base_agent_with_bing import base_agent_with_bing


# Expert Opinions
async def expert_opinions_tool_agent(stock_name: str) -> str:
    """
    Agent function to fetch expert opinions for a given stock name.
    Args:
        stock_name: The name of the stock to fetch reports for.
        project_client: The AIProjectClient instance.
        model_name: The model name to use.
        bing_connection: The Bing connection properties.
    """
    agent_name = "expert_opinions_tool_agent"
    instructions = (
        f"Focus on industry expert or thought leader opinions "
        f"regarding {stock_name}."
    )
    content = (
        f"Collect expert opinions or quotes about {stock_name}."
    )
    print(
        f"[{agent_name}] "
        f"Fetching expert opinions for {stock_name}..."
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
