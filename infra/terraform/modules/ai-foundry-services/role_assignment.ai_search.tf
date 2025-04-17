// role_assignment.ai_services.tf

resource "azurerm_role_assignment" "ra_srch" {
  count                = var.enable_ai_search ? 1 : 0
  scope                = var.ai_foundry_hub_storage_id
  principal_id         = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.srch[0].principal_id : azurerm_search_service.this[0].identity[0].principal_id
  role_definition_name = "Storage Blob Data Reader"

  depends_on = [
    azurerm_user_assigned_identity.srch,
  ]
}

// https://learn.microsoft.com/en-us/azure/ai-foundry/tutorials/deploy-chat-web-app#assign-roles
// Addtional role assignments for Azure AI services
// Scope = Azure AI services
//  - Cognitive Services OpenAI Contributor to the Search service managed identity

resource "azurerm_role_assignment" "ra_srch_ais1" {
  count                = var.enable_ai_search ? 1 : 0
  scope                = azurerm_ai_services.this.id
  principal_id         = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.srch[0].principal_id : azurerm_search_service.this[0].identity[0].principal_id
  role_definition_name = "Cognitive Services OpenAI Contributor"

  depends_on = [
    azurerm_ai_services.this,
    azurerm_user_assigned_identity.srch,
  ]
}
