// role_assignment.ai_services.tf

resource "azurerm_role_assignment" "ra_ais" {
  scope                = var.ai_foundry_hub_storage_id
  principal_id         = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.ais[0].principal_id : azurerm_ai_services.this.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"

  depends_on = [
    azurerm_user_assigned_identity.ais,
  ]
}
