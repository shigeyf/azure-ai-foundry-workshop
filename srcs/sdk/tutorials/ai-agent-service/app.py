"""
Investment decision-making AI Agent application
"""

import asyncio

from autogen_agentchat.ui import Console
from agents.investment_team import investment_team
from messages_ja import query
from project import tracer, tracer_scenario
from opentelemetry import trace


async def main():
    """Main function to run the investment decision-making process."""
    stock_name = "Tesla"
    await Console(
        investment_team.run_stream(
            task=query.format(stock_name=stock_name),
        )
    )


if __name__ == "__main__":
    with tracer.start_as_current_span(tracer_scenario) as root_span:
        asyncio.run(main())
