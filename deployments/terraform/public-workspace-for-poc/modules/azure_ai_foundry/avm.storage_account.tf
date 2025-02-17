//

module "storage_account" {
  source = "Azure/avm-res-storage-storageaccount/azurerm"
  //version = "0.5.0"

  // Basic properties
  name                = local.storage_account_name
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  tags                = var.tags

  // Advanced properties
  account_kind                      = "StorageV2"
  account_replication_type          = "LRS"
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = true
  network_rules = {
    default_action = "Allow"
  }
  sftp_enabled              = false
  shared_access_key_enabled = false

  managed_identities = {
    system_assigned            = true
    user_assigned_resource_ids = [module.user_assigned_identity_for_storage.resource_id]
  }

  customer_managed_key = {
    key_vault_resource_id = module.key_vault.resource_id
    key_name              = local.cmk_name_for_storage
    user_assigned_identity = {
      resource_id = module.user_assigned_identity_for_storage.resource_id
    }
  }
}
