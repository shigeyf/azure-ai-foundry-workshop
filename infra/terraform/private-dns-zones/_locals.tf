// _locals.tf

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

locals {
  # Local variables for resource group creation
  create_resource_group_name = module.naming.resource_group.name_unique
  # Local variables for created resource group
  resource_group_name = var.use_existing_rg ? data.azurerm_resource_group.rg[0].name : azurerm_resource_group.rg[0].name
}
