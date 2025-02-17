// envs/dev/locals.tf

// Define resource names according to the Azure naming conventions.
locals {
  resource_group_name  = module.global.naming.resource_group.name
  storage_account_name = module.global.naming.storage_account.name
  key_vault_name       = module.global.naming.key_vault.name
}
