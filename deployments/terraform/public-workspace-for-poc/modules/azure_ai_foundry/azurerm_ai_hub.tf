// azurerm_ai_hub.tf

// AzAPI AI Foundry Hub resource
resource "azapi_resource" "hub" {
  type = "Microsoft.MachineLearningServices/workspaces@2024-07-01-preview"

  // Basic properties
  name      = local.ai_hub_name
  location  = local.resource_group_location
  parent_id = local.resource_group_id
  tags      = var.tags

  identity {
    type = "SystemAssigned"
  }

  // API Request Body
  body = {
    properties = {
      description              = local.ai_hub_name
      friendlyName             = local.ai_hub_name
      storageAccount           = module.storage_account.resource_id
      keyVault                 = module.key_vault.resource_id
      systemDatastoresAuthMode = "identity"
      publicNetworkAccess      = "Enabled"
    }
    kind = "hub"
  }

  depends_on = [
    module.storage_account,
    module.key_vault,
  ]
}
