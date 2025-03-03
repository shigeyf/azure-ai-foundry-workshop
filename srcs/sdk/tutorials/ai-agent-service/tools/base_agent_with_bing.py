"""
An baseline AI Agent implementation.
This example uses the Azure AI Agent Service and the Bing Grounding Tool.
"""

from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import BingGroundingTool, ConnectionProperties
from tools.ai_agent_properties import AIAgentProperties
from project import tracer


@tracer.start_as_current_span("tutorials: ai-agent-service[base_agent_with_bing]")
async def base_agent_with_bing(
    project_client: AIProjectClient,
    model_name: str,
    agent_properties: AIAgentProperties,
    bing_connection: ConnectionProperties,
) -> str:
    """A baseline AI Agent implementation."""
    agent_name = agent_properties.agent_name or None

    bing = BingGroundingTool(connection_id=bing_connection.id)
    agent = project_client.agents.create_agent(
        name=agent_name,
        model=model_name,
        instructions=agent_properties.instructions,
        tools=bing.definitions,
        headers={"x-ms-enable-preview": "true"},
    )
    # print(f"[{agent_name}] Created agent, ID: {agent.id}")

    # Create a new thread and send the user query
    thread = project_client.agents.create_thread()
    # print(f"[{agent_name}] Created thread, ID: {thread.id}")

    # Create message to thread
    _message = project_client.agents.create_message(
        thread_id=thread.id,
        role="user",
        content=agent_properties.content,
    )
    # print(f"[{agent_name}] Created message: {_message}")

    # Process the run
    _run = project_client.agents.create_and_process_run(
        thread_id=thread.id,
        assistant_id=agent.id,
    )
    print(f"[{agent_name}] Run finished with status: {_run.status}")
    if _run.status == "failed":
        print(f"[{agent_name}] Run failed: {_run.last_error}")

    # Fetch and log all messages
    messages = project_client.agents.list_messages(
        thread_id=thread.id
    )
    # print(
    #    f"[{agent_name}] Messages: "
    #    f"{messages["data"][0]["content"][0]["text"]["value"]}"
    #)

    # Clean up - Delete the assistant when done
    project_client.agents.delete_agent(agent.id)

    # Return the Bing result
    return messages["data"][0]["content"][0]["text"]["value"]
