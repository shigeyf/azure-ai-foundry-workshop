// modules/*/locals.tf

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.4.0"
}

locals {
  resource_group_name     = module.rg.resource.name
  resource_group_location = module.rg.resource.location
  key_vault_name          = "${substr(replace(var.key_vault_name, "-", ""), 0, (module.naming.key_vault.max_length - var.unique_suffix_length))}${var.unique_suffix}"
  storage_account_name    = "${substr(var.storage_account_name, 0, (module.naming.key_vault.max_length - var.unique_suffix_length))}${var.unique_suffix}"
}

locals {
  uami_name_for_storage = "uami-${local.storage_account_name}"
  cmk_name_for_storage  = "cmk-for-storage-${local.storage_account_name}"
}
