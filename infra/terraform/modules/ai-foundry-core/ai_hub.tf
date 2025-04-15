// ai_hub.tf

resource "azurerm_ai_foundry" "this" {
  name                = var.ai_foundry_hub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  description        = var.ai_foundry_hub_description == null ? var.ai_foundry_hub_name : var.ai_foundry_hub_description
  friendly_name      = var.ai_foundry_hub_friendly_name == null ? var.ai_foundry_hub_name : var.ai_foundry_hub_friendly_name
  storage_account_id = module.core_storage.output.storage_id
  key_vault_id       = module.core_kv.output.keyvault_id

  public_network_access        = var.enable_public_network_access ? "Enabled" : "Disabled"
  high_business_impact_enabled = var.high_business_impact_enabled

  # application_insights_id        = azurerm_application_insights.this.id
  # container_registry_id          = azurerm_container_registry.this.id
  # primary_user_assigned_identity = null

  # Enable system-assigned managed identity
  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id,
    ]
  }

  # encryption {
  #   key_id                    = null
  #   key_vault_id              = null
  #   user_assigned_identity_id = null
  # }

  # managed_network {
  #   isolation_mode = "Disabled"
  # }

  lifecycle {
    # Ignore entire "tags" property, since there is no way to ignore only specific tags with "__SYSTEM__" prefix
    ignore_changes = [
      tags,
      // Currently, there is no way to set tag patterns with "*" or dynamic value
      //tags["__SYSTEM__AIServices_${var.ai_services_name}"], // A single static variable reference is required
      //tags["__SYSTEM__AzureOpenAI_${name}_aoai"], // A single static variable reference is required
    ]
  }
}
