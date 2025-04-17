// ai_services_apiky.tf

// content_type = WorkspaceConnectionSecret
// name = {workspace_id}-{ai services name without hypen}
// name = {workspace_id}-{ai services name without hypen}aoai

locals {
  ais_secret_name  = "${var.ai_foundry_hub_workspace_id}-${replace(azurerm_ai_services.this.name, "-", "")}"
  aoai_secret_name = "${var.ai_foundry_hub_workspace_id}-${replace(azurerm_ai_services.this.name, "-", "")}aoai"
}

resource "azurerm_key_vault_secret" "apikey_ais" {
  name         = local.ais_secret_name
  value        = azurerm_ai_services.this.primary_access_key
  content_type = "WorkspaceConnectionSecret"
  key_vault_id = var.ai_foundry_hub_keyvault_id

  lifecycle {
    ignore_changes = [
      expiration_date,
    ]
  }
}

resource "azurerm_key_vault_secret" "apikey_aoai" {
  name         = local.aoai_secret_name
  value        = azurerm_ai_services.this.primary_access_key
  content_type = "WorkspaceConnectionSecret"
  key_vault_id = var.ai_foundry_hub_keyvault_id

  lifecycle {
    ignore_changes = [
      expiration_date,
    ]
  }
}
