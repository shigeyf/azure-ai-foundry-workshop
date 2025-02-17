// modules/*/locals.tf

locals {
  resource_group_name     = module.rg.resource.name
  resource_group_location = module.rg.resource.location
  key_vault_name          = "${substr(replace(replace(var.key_vault_name, "-", ""), "kv", "kv-"), 0, 20)}${var.unique_suffix}"
  storage_account_name    = "${substr(var.storage_account_name, 0, 20)}${var.unique_suffix}"
}

locals {
  uami_name_for_storage = "uami-${local.storage_account_name}"
  cmk_name_for_storage  = "cmk-for-storage-${local.storage_account_name}"
}
