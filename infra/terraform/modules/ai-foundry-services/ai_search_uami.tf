// ai_search_uami.tf

resource "azurerm_user_assigned_identity" "srch" {
  count               = var.enable_user_assigned_identity ? 1 : 0
  name                = var.ai_search_uami_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
