// ai_services.tf

resource "azurerm_ai_services" "this" {
  name                  = var.ai_services_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  sku_name              = var.ai_services_sku
  custom_subdomain_name = var.ai_services_name

  public_network_access = var.enable_public_network_access ? "Enabled" : "Disabled"

  # Enable system-assigned managed identity
  identity {
    type         = var.enable_user_assigned_identity ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.ais[0].id] : []
  }

  depends_on = [
    azurerm_user_assigned_identity.ais,
  ]
}
