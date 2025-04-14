"""
An AI Agent implementation to fetch analyst reports for a given stock name.
"""

from opentelemetry import trace

from config import env_MODEL_NAME
from project import bing_connection, project_client, tracer
from tools.ai_agent_properties import AIAgentProperties
from tools.base_agent_with_bing import base_agent_with_bing
from messages_ja import (
  analysis_report_tool_instructions,
  analysis_report_tool_content,
)


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
    currspan = trace.get_current_span()
    with tracer.start_as_current_span(
        "analyst_reports_tool_agent",
        context=trace.set_span_in_context(currspan),
    ):
        agent_name = "analyst_reports_tool_agent"
        instructions = analysis_report_tool_instructions.format(stock_name=stock_name)
        content = analysis_report_tool_content.format(stock_name=stock_name)
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
