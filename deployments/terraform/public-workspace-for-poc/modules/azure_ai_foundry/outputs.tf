// modules/*/output.tf

output "resource_names" {
  value = {
    resource_group  = local.resource_group_name
    key_vault       = local.key_vault_name
    storage_account = local.storage_account_name
  }
}
