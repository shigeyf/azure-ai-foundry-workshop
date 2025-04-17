// _outputs.tf

output "output" {
  value = {
    ai_foundry_project_id                     = azurerm_ai_foundry_project.this.id
    ai_foundry_project_workspace_id           = azurerm_ai_foundry_project.this.project_id
    ai_foundry_project_managed_identity       = azurerm_ai_foundry_project.this.identity[0].principal_id
    ai_foundry_project_user_assigned_identity = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].id : null
  }
  description = "Project resources for AI Foundry"
}
