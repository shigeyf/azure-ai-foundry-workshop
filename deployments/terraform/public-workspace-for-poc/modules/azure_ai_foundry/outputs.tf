// output.tf

output "resource_names" {
  value = {
    resource_group         = local.resource_group_name
    user_assigned_identity = local.uami_name_for_storage
    key_vault              = local.key_vault_name
    storage_account        = local.storage_account_name
  }
}
