// _outputs.tf

output "output" {
  value = {
    ai_foundry_hub_id               = azurerm_ai_foundry.this.id
    ai_foundry_hub_workspace_id     = azurerm_ai_foundry.this.workspace_id
    ai_foundry_project_uami_id      = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].id : null
    ai_foundry_hub_keyvault_id      = module.core_kv.output.keyvault_id
    ai_foundry_hub_storage_id       = module.core_storage.output.storage_id
    ai_foundry_hub_storage_uami_id  = module.core_storage.output.storage_uai_id
    ai_foundry_hub_storage_cmk_name = module.core_storage_cmkey.output.key_name
  }
  description = "Core resources for AI Foundry"
}
