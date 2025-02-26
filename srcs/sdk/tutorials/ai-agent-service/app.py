"""
Investment decision-making AI Agent application
"""

import asyncio

from autogen_agentchat.ui import Console
from agents.investment_team import investment_team
from messages_ja import query


async def main():
    """Main function to run the investment decision-making process."""
    stock_name = "Tesla"
    await Console(
        investment_team.run_stream(
            task=query.format(stock_name=stock_name),
        )
    )


if __name__ == "__main__":
    asyncio.run(main())
