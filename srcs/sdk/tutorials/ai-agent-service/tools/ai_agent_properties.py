"""
A class for AI Agent Properties.
"""

import dataclasses


@dataclasses.dataclass
class AIAgentProperties:
    """AIAgentProperties class."""
    agent_name: str | None
    instructions: str
    content: str
