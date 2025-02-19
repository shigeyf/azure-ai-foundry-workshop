// avm.key_vault_role_cmk_for_storage.tf

module "role_assignments_for_key_vault_cmk_for_storage" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "0.2.0"

  role_assignments_azure_resource_manager = {
    custmer_managed_key = {
      principal_id         = module.user_assigned_identity_for_storage.principal_id
      role_definition_name = "Key Vault Crypto Officer"
      scope                = module.key_vault.resource_id
    }
  }

  // Depends on
  depends_on = [
    module.key_vault,
    module.user_assigned_identity_for_storage,
  ]
}
