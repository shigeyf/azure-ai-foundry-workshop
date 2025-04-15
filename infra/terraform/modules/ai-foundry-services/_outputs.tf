// _outputs.tf

output "output" {
  value = {
    ai_services_id      = azurerm_ai_services.this.id
    ai_services_uami_id = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.ais[0].id : null
  }
  description = "AI service resources for AI Foundry"
}
