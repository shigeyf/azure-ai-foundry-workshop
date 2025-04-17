// ai_search.tf

resource "azurerm_search_service" "this" {
  count               = var.enable_ai_search ? 1 : 0
  name                = var.ai_search_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                                      = var.ai_search_sku
  hosting_mode                             = var.ai_search_hosting_mode
  authentication_failure_mode              = "http403"
  local_authentication_enabled             = true
  public_network_access_enabled            = var.enable_public_network_access
  partition_count                          = var.ai_search_sku != "free" ? var.ai_search_partition_count : null
  replica_count                            = var.ai_search_sku != "free" ? var.ai_search_replica_count : null
  customer_managed_key_enforcement_enabled = var.ai_search_customer_managed_key_enforcement_enabled
  semantic_search_sku                      = var.ai_search_sku != "free" ? var.ai_search_semantic_search_sku : null

  # Enable system-assigned managed identity
  identity {
    type         = var.enable_user_assigned_identity ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.srch[0].id] : []
  }
}
