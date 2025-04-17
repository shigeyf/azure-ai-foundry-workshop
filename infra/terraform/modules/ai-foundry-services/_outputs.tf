// _outputs.tf

output "output" {
  value = {
    ai_services_id                     = azurerm_ai_services.this.id
    ai_services_managed_identity       = azurerm_ai_services.this.identity[0].principal_id
    ai_services_user_assigned_identity = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.ais[0].id : null
    ai_search_id                       = var.enable_ai_search ? azurerm_search_service.this[0].id : null
    ai_search_managed_identity         = var.enable_ai_search ? azurerm_search_service.this[0].identity[0].principal_id : null
    ai_search_user_assigned_identity   = var.enable_ai_search ? (var.enable_user_assigned_identity ? azurerm_user_assigned_identity.srch[0].id : null) : null
  }
  description = "AI service resources for AI Foundry"
}
