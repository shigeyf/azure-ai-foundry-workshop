"""
An AutoGen Team implementation of agents
that will work together to make a decision.
"""

from autogen_agentchat.conditions import (MaxMessageTermination,
                                          TextMentionTermination)
from autogen_agentchat.teams import RoundRobinGroupChat
from agents.investment_decision_agent import investment_decision_agent_assistant
from agents.news_analysis_agent import news_analysis_agent_assistant
from agents.stock_price_trends_agent import stock_price_trends_agent_assistant
from agents.stock_sentiment_agent import stock_sentiment_agent_assistant
from messages_ja import TERMINATION_WORDS

# Stop once TERMINATION_WORDS is in the response, or if 15 messages have passed
text_termination = TextMentionTermination(TERMINATION_WORDS)
max_message_termination = MaxMessageTermination(15)
termination = text_termination | max_message_termination

# Round-robin chat among the four agents
investment_team = RoundRobinGroupChat(
    [
        stock_price_trends_agent_assistant,
        news_analysis_agent_assistant,
        stock_sentiment_agent_assistant,
        investment_decision_agent_assistant,
    ],
    termination_condition=termination
)
