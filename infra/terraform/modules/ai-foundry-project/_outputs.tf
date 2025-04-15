// _outputs.tf

output "output" {
  value = {
    ai_foundry_project_id           = azurerm_ai_foundry_project.this.id
    ai_foundry_project_workspace_id = azurerm_ai_foundry_project.this.project_id
    ai_foundry_project_uami_id      = azurerm_user_assigned_identity.this.id
  }
}
