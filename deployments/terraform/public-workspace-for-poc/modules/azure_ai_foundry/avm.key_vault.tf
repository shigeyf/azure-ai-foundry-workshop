//

module "key_vault" {
  source = "Azure/avm-res-keyvault-vault/azurerm"
  // version = "0.9.1"

  // Basic properties
  name                = local.key_vault_name
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags

  // Advanced properties
  public_network_access_enabled = true
  network_acls = {
    default_action = "Allow"
  }

  keys = {
    cmk_for_storage = {
      key_opts = [
        "decrypt",
        "encrypt",
        "sign",
        "unwrapKey",
        "verify",
        "wrapKey"
      ]
      key_type = "RSA"
      name     = local.cmk_name_for_storage
      key_size = 2048
    }
  }

  role_assignments = {
    deployment_user_secrets = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.current.object_id
    }
    customer_managed_key = {
      role_definition_id_or_name = "Key Vault Crypto Officer"
      principal_id               = module.user_assigned_identity_for_storage.principal_id
    }
  }
}
