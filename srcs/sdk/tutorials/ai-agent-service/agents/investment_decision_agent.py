"""
An AutoGen Investment Decision Agent implementation
"""

from autogen_agentchat.agents import AssistantAgent
from project import inference_model_client
from messages_ja import decision_agent_system_message
from project import tracer


# Assistant Agent: Investment Decision
with tracer.start_as_current_span("tutorials: ai-agent-service[investment_decision_agent]"):
  investment_decision_agent_assistant = AssistantAgent(
      name="investment_decision_agent",
      model_client=inference_model_client,
      # The final agent typically calls the 'investment_decision_agent' to
      # synthesize all the data. If you want it to call the other tools directly,
      # you can also add them here.
      # But typically we rely on the round-robin approach.
      # tools=[investment_decision_agent],
      system_message=decision_agent_system_message,
  )
