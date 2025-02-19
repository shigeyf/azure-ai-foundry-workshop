// locals.tf

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.4.0"
}

locals {
  resource_group_id            = module.rg.resource.id
  resource_group_name          = module.rg.resource.name
  resource_group_location      = module.rg.resource.location
  key_vault_name               = "${substr(format("%s%s", substr(var.key_vault_name, 0, 3), substr(replace(var.key_vault_name, "-", ""), 2, -1)), 0, (module.naming.key_vault.max_length - var.unique_suffix_length - 1))}-${var.unique_suffix}"
  storage_account_name         = "${substr(var.storage_account_name, 0, (module.naming.key_vault.max_length - var.unique_suffix_length))}${var.unique_suffix}"
  log_analytics_workspace_name = "${var.log_analytics_workspace_name}-${var.unique_suffix}"
  application_insights_name    = "${var.application_insights_name}-${var.unique_suffix}"
  ai_service_name              = "${var.ai_service_name}-${var.unique_suffix}"
  ai_hub_name                  = "${var.ai_hub_name}-${var.unique_suffix}"
}

locals {
  uami_name_for_storage = "uami-${local.storage_account_name}"
  uami_name_for_aihub   = "uami-${local.ai_hub_name}"
  cmk_name_for_storage  = "cmk-for-storage-${local.storage_account_name}"
}
