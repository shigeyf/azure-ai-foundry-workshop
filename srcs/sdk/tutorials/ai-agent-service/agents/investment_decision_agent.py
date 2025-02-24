"""
An AutoGen Investment Decision Agent implementation
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client

TERMINATION_WORDS = "Decision Made"

investment_decision_agent_assistant = AssistantAgent(
    name="investment_decision_agent",
    model_client=inference_model_client,
    # The final agent typically calls the 'investment_decision_agent' to
    # synthesize all the data. If you want it to call the other tools directly,
    # you can also add them here.
    # But typically we rely on the round-robin approach.
    # tools=[investment_decision_agent],
    system_message=(
        f"You are the Decision Agent. "
        f"After reviewing the stock data, news, sentiment, analyst reports, "
        f"and expert opinions from the other agents, "
        f"you provide the final investment decision. "
        f"In the final decision make a call to either Invest or Not. "
        f"Also provide the current stock price. "
        f"End your response with '{TERMINATION_WORDS}' "
        f"once you finalize the decision."
    )
)
