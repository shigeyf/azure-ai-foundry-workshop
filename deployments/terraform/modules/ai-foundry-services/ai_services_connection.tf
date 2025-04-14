// ai_services_connections.tf

data "azurerm_key_vault_secret" "apikey_aoai" {
  name         = azurerm_key_vault_secret.apikey_aoai.name
  key_vault_id = var.ai_foundry_hub_keyvault_id
}

data "azurerm_key_vault_secret" "apikey_ais" {
  name         = azurerm_key_vault_secret.apikey_ais.name
  key_vault_id = var.ai_foundry_hub_keyvault_id
}

# Temporary workaround: Get Azure AI Services resource to get "endpoints" property
data "azapi_resource" "ais_target" {
  name                   = azurerm_ai_services.this.name
  parent_id              = data.azurerm_resource_group.target.id
  type                   = "Microsoft.CognitiveServices/accounts@2024-10-01"
  response_export_values = ["properties.endpoints"]
}

resource "azapi_resource" "aoai_connections" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name      = "${azurerm_ai_services.this.name}_aoai"
  parent_id = var.ai_foundry_hub_id

  body = {
    properties = {
      category      = "AzureOpenAI"
      isSharedToAll = true
      metadata = {
        "ApiType" : "Azure",
        "ApiVersion" : "2023-07-01-preview",
        "DeploymentApiVersion" : "2023-10-01-preview",
        "Location" : var.location,
        "ResourceId" : azurerm_ai_services.this.id,
      }
      target = data.azapi_resource.ais_target.output.properties.endpoints["OpenAI Language Model Instance API"]
      # "AuthType for AzureOpenAI Connection can only be AAD or ApiKey or DelegatedSAS"
      authType = "ApiKey"
      credentials = {
        key = data.azurerm_key_vault_secret.apikey_aoai.value
      }
    }
  }

  ignore_casing             = false
  ignore_missing_property   = true
  schema_validation_enabled = false

  depends_on = [
    azurerm_key_vault_secret.apikey_aoai,
  ]
}

resource "azapi_resource" "ais_connection" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name      = azurerm_ai_services.this.name
  parent_id = var.ai_foundry_hub_id

  body = {
    properties = {
      category      = "AIServices"
      isSharedToAll = true
      metadata = {
        "ApiType" : "Azure",
        "ApiVersion" : "2023-07-01-preview",
        "DeploymentApiVersion" : "2023-10-01-preview",
        "Location" : var.location,
        "ResourceId" : azurerm_ai_services.this.id,
      }
      target = azurerm_ai_services.this.endpoint
      # "AuthType for AIServices Connection can only be AAD or ApiKey or DelegatedSAS"
      authType = "ApiKey"
      credentials = {
        key = data.azurerm_key_vault_secret.apikey_ais.value
      }
    }
  }

  ignore_casing             = false
  ignore_missing_property   = true
  schema_validation_enabled = true

  depends_on = [
    azurerm_key_vault_secret.apikey_ais,
    azapi_resource.aoai_connections,
  ]
}

