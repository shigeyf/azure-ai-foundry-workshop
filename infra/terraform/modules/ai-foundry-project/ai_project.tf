// ai_project.tf

resource "azurerm_ai_foundry_project" "this" {
  name     = var.ai_foundry_project_name
  location = var.location
  tags     = var.tags

  description = (
    var.ai_foundry_project_description == null
    ? var.ai_foundry_project_name
    : var.ai_foundry_project_description
  )
  friendly_name = (
    var.ai_foundry_project_friendly_name == null
    ? var.ai_foundry_project_name
    : var.ai_foundry_project_friendly_name
  )
  ai_services_hub_id           = var.ai_foundry_hub_id
  high_business_impact_enabled = var.high_business_impact_enabled

  # Enable system-assigned managed identity
  identity {
    type         = var.enable_user_assigned_identity ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.this[0].id] : []
  }

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}
