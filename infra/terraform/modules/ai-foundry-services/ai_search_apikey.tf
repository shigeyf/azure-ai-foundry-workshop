// ai_search_apiky.tf

// content_type = WorkspaceConnectionSecret
// name = {workspace_id}-AzureAISearch

locals {
  srch_secret_name = "${var.ai_foundry_hub_workspace_id}-AzureAISearch"
}

resource "azurerm_key_vault_secret" "apikey_srch" {
  count        = var.enable_ai_search ? 1 : 0
  name         = local.srch_secret_name
  value        = azurerm_search_service.this[0].primary_key
  content_type = "WorkspaceConnectionSecret"
  key_vault_id = var.ai_foundry_hub_keyvault_id

  lifecycle {
    ignore_changes = [
      expiration_date,
    ]
  }
}
