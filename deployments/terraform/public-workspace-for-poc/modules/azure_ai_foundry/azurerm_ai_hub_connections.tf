// azurerm_ai_hub_connections.tf

// AzAPI AI Services Connection resource
resource "azapi_resource" "AIServicesConnection" {
  type = "Microsoft.MachineLearningServices/workspaces/connections@2024-07-01-preview"

  name      = local.ai_service_name
  parent_id = azapi_resource.hub.id

  // API Request Body
  body = {
    properties = {
      category      = "AIServices",
      target        = azapi_resource.AIServicesResource.output.properties.endpoint,
      authType      = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azapi_resource.AIServicesResource.id
      }
    }
  }
  response_export_values = ["*"]

  depends_on = [
    azapi_resource.AIServicesResource,
    azapi_resource.hub,
  ]
}

// AzAPI Azure OpenAI Service Connection resource
resource "azapi_resource" "AzureOpenAIServiceConnection" {
  type = "Microsoft.MachineLearningServices/workspaces/connections@2024-07-01-preview"

  name      = "${local.ai_service_name}_aoai"
  parent_id = azapi_resource.hub.id

  // API Request Body
  body = {
    properties = {
      category      = "AzureOpenAI",
      target        = azapi_resource.AIServicesResource.output.properties.endpoints["OpenAI Language Model Instance API"],
      authType      = "AAD",
      isSharedToAll = true,
      metadata = {
        ApiType    = "Azure",
        ResourceId = azapi_resource.AIServicesResource.id
      }
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]

  depends_on = [
    azapi_resource.AIServicesResource,
    azapi_resource.hub,
  ]
}
