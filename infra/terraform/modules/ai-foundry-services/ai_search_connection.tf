// ai_search_connections.tf

data "azurerm_key_vault_secret" "apikey_srch" {
  count        = var.enable_ai_search ? 1 : 0
  name         = azurerm_key_vault_secret.apikey_srch[0].name
  key_vault_id = var.ai_foundry_hub_keyvault_id
}

# Temporary workaround: Get Azure AI Search resource to get "endpoints" property
data "azapi_resource" "srch_target" {
  count                  = var.enable_ai_search ? 1 : 0
  name                   = azurerm_search_service.this[0].name
  parent_id              = data.azurerm_resource_group.target.id
  type                   = "Microsoft.Search/searchServices@2025-02-01-preview"
  response_export_values = ["properties.endpoint"]

  depends_on = [
    azurerm_search_service.this,
  ]
}

resource "azapi_resource" "srch_connections" {
  count     = var.enable_ai_search ? 1 : 0
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name      = "AzureAISearch"
  parent_id = var.ai_foundry_hub_id

  body = {
    properties = {
      category      = "CognitiveSearch"
      isSharedToAll = true
      metadata = {
        "ApiType" : "Azure",
        "ApiVersion" : "2024-05-01-preview",
        "DeploymentApiVersion" : "2023-11-01",
        "Location" : var.location,
        "ResourceId" : azurerm_search_service.this[0].id,
      }
      target   = data.azapi_resource.srch_target[0].output.properties.endpoint
      authType = "ApiKey"
      credentials = {
        key = data.azurerm_key_vault_secret.apikey_srch[0].value
      }
    }
  }

  ignore_casing             = false
  ignore_missing_property   = true
  schema_validation_enabled = true

  depends_on = [
    azurerm_key_vault_secret.apikey_srch,
  ]
}
