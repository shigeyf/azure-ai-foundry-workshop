// role_assignment.ai_services.tf

//
// Role Assignments for AI Servces Identity
//

resource "azurerm_role_assignment" "ais_ra_st" {
  count                = local.use_managed_identity ? 1 : 0
  scope                = var.ai_foundry_hub_storage_id
  principal_id         = azurerm_ai_services.this.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"

  depends_on = [
    azurerm_ai_services.this,
  ]
}

resource "azurerm_role_assignment" "ais_uai_ra_st" {
  count                = local.use_user_assigned_identity ? 1 : 0
  scope                = var.ai_foundry_hub_storage_id
  principal_id         = azurerm_user_assigned_identity.ais[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"

  depends_on = [
    azurerm_user_assigned_identity.ais,
  ]
}

// https://learn.microsoft.com/en-us/azure/ai-foundry/tutorials/deploy-chat-web-app#assign-roles
// Addtional role assignments for Azure AI services
// Scope =  Search service
//  - Search Index Data Reader to the Azure AI services managed identity
//  - Search Service Contributor to the Azure AI services managed identity

resource "azurerm_role_assignment" "ais_ra_srch1" {
  count                = var.enable_ai_search && local.use_managed_identity ? 1 : 0
  scope                = azurerm_search_service.this[0].id
  principal_id         = azurerm_ai_services.this.identity[0].principal_id
  role_definition_name = "Search Index Data Reader"

  depends_on = [
    azurerm_ai_services.this,
    azurerm_search_service.this,
  ]
}

resource "azurerm_role_assignment" "ais_ra_srch2" {
  count                = var.enable_ai_search && local.use_managed_identity ? 1 : 0
  scope                = azurerm_search_service.this[0].id
  principal_id         = azurerm_ai_services.this.identity[0].principal_id
  role_definition_name = "Search Service Contributor"

  depends_on = [
    azurerm_ai_services.this,
    azurerm_search_service.this,
  ]
}

resource "azurerm_role_assignment" "ais_uai_ra_srch1" {
  count                = var.enable_ai_search && local.use_user_assigned_identity ? 1 : 0
  scope                = azurerm_search_service.this[0].id
  principal_id         = azurerm_user_assigned_identity.ais[0].principal_id
  role_definition_name = "Search Index Data Reader"

  depends_on = [
    azurerm_user_assigned_identity.ais,
    azurerm_search_service.this,
  ]
}

resource "azurerm_role_assignment" "ais_uai_ra_srch2" {
  count                = var.enable_ai_search && local.use_user_assigned_identity ? 1 : 0
  scope                = azurerm_search_service.this[0].id
  principal_id         = azurerm_user_assigned_identity.ais[0].principal_id
  role_definition_name = "Search Service Contributor"

  depends_on = [
    azurerm_user_assigned_identity.ais,
    azurerm_search_service.this,
  ]
}
