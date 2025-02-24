"""
Investment decision-making AI Agent application
"""

import asyncio

from autogen_agentchat.ui import Console
from agents.investment_team import investment_team


async def main():
    """Main function to run the investment decision-making process."""
    stock_name = "Tesla"
    await Console(
        investment_team.run_stream(
            task=(
                f"Analyze stock trends, news, and sentiment for {stock_name}, "
                f"plus analyst reports and expert opinions, "
                f"and then decide whether to invest."
            )
        )
    )


if __name__ == "__main__":
    asyncio.run(main())
