// locals.tf

// Load a module for Azure Region names and short names
module "azure_region" {
  source       = "claranet/regions/azurerm"
  version      = "8.0.1"
  azure_region = var.location
}

locals {
  location_short_name = module.azure_region.location_short
}

// Load a module for Azure Resource naming
module "naming" {
  # tflint-ignore: terraform_module_pinned_source
  source         = "git::https://github.com/shigeyf/terraform-azurerm-naming?ref=master"
  suffix         = concat(var.naming_suffix, [local.location_short_name])
  suffix-padding = 4
}

// Naming variables for AI Foundry resources
locals {
  # Local variables for all resource creation
  location = var.location
  tags     = var.tags

  # Local variables for resource group creation
  create_resource_group_name = module.naming.resource_group.name_unique

  # Local variables for all other resource creation than resource group
  # Resource group name is top dependent resource, and other creation should be waiting for resource group creation.
  resource_group_name  = azurerm_resource_group.base.name
  keyvault_name        = module.naming.key_vault.short_name_unique
  storage_account_name = module.naming.storage_account.short_name_unique
  storage_uami_name    = "${module.naming.user_assigned_identity.name_unique}-${module.naming.storage_account.slug}"
  storage_cmk_key_name = "cmk-${local.storage_account_name}"
  ai_foundry_hub_name  = replace(module.naming.resource_group.name_unique, "/^rg-/", "hub-")
  ai_services_name     = replace(module.naming.resource_group.name_unique, "/^rg-/", "ais-")
}
