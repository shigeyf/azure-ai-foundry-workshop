// avm.key_vault_role_admins.tf

/*
module "role_assignments_for_key_vault_admins" {
  source  = "Azure/avm-res-authorization-roleassignment/azurerm"
  version = "0.2.0"

  role_assignments_azure_resource_manager = {
    deployment_user_secrets = {
      principal_id         = data.azurerm_client_config.current.object_id
      role_definition_name = "Key Vault Administrator"
      scope                = module.key_vault.resource_id
    }
  }

  // Depends on
  depends_on = [
    module.key_vault,
  ]
}
*/
