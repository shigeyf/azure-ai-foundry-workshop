// ai_project_uami.tf

resource "azurerm_user_assigned_identity" "this" {
  name                = var.ai_foundry_project_uami_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
