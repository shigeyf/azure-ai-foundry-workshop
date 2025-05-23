// _outputs.tf

output "output" {
  value = {
    ai_foundry_hub_id                             = azurerm_ai_foundry.this.id
    ai_foundry_hub_workspace_id                   = azurerm_ai_foundry.this.workspace_id
    ai_foundry_hub_managed_identity               = azurerm_ai_foundry.this.identity[0].principal_id
    ai_foundry_hub_user_assigned_identity         = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.hub[0].principal_id : null
    ai_foundry_hub_keyvault_id                    = module.core_kv.output.keyvault_id
    ai_foundry_hub_storage_id                     = module.core_storage.output.storage_id
    ai_foundry_hub_storage_user_assigned_identity = module.core_storage.output.storage_uai_id
    ai_foundry_hub_storage_cmk_name               = module.core_storage_cmkey.output.key_name
    ai_foundry_app_insights_id                    = var.enable_app_insights ? azurerm_application_insights.this[0].id : null
  }
  description = "Core resources for AI Foundry"
}
