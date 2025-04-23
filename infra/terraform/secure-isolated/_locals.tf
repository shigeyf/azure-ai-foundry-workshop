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
  resource_group_name      = azurerm_resource_group.base.name
  keyvault_name            = module.naming.key_vault.short_name_unique
  storage_account_name     = module.naming.storage_account.short_name_unique
  storage_uami_name        = "${module.naming.user_assigned_identity.name_unique}-${module.naming.storage_account.slug}"
  storage_cmk_key_name     = "cmk-${local.storage_account_name}"
  ai_foundry_hub_name      = replace(module.naming.resource_group.name_unique, "/^rg-/", "hub-")
  ai_foundry_hub_uami_name = "${module.naming.user_assigned_identity.name_unique}-hub"
  #ai_foundry_hub_cmk_key_name  = "cmk-${local.ai_foundry_hub_name}"
  ai_services_name             = replace(module.naming.resource_group.name_unique, "/^rg-/", "ais-")
  ai_services_uami_name        = "${module.naming.user_assigned_identity.name_unique}-ais"
  ai_search_name               = module.naming.search_service.name_unique
  ai_search_uami_name          = "${module.naming.user_assigned_identity.name_unique}-${module.naming.search_service.slug}"
  ai_foundry_project_name      = replace(module.naming.resource_group.name_unique, "/^rg-/", "proj-")
  ai_foundry_project_uami_name = "${module.naming.user_assigned_identity.name_unique}-proj"
  app_insights_name            = "${module.naming.application_insights.name_unique}-hub"

  vnet_name                            = module.naming.virtual_network.name_unique
  keyvault_private_endpoint_name       = "${module.naming.private_endpoint.name_unique}-${module.naming.key_vault.slug}"
  storage_privete_endpoint_name        = "${module.naming.private_endpoint.name_unique}-${module.naming.storage_account.slug}"
  ai_foundry_hub_private_endpoint_name = "${module.naming.private_endpoint.name_unique}-hub"
  ai_services_private_endpoint_name    = "${module.naming.private_endpoint.name_unique}-ais"
  ai_search_private_endpoint_name      = "${module.naming.private_endpoint.name_unique}-${module.naming.search_service.slug}"
  nat_gateway_name                     = module.naming.nat_gateway.name_unique
  nat_gateway_public_ip_name           = "${module.naming.public_ip.name_unique}-${module.naming.nat_gateway.slug}"
  bastion_host_name                    = module.naming.bastion_host.name_unique
  bastion_public_ip_name               = "${module.naming.public_ip.name_unique}-${module.naming.bastion_host.slug}"
  vpn_gateway_name                     = module.naming.virtual_network_gateway.name_unique
  vpn_gateway_public_ip_name           = "${module.naming.public_ip.name_unique}-${module.naming.virtual_network_gateway.slug}"
}

locals {
  days_match      = regex("^P([0-9]+)D$", var.storage_cmk_key_policy.rotation_policy.expire_after)
  days            = tonumber(local.days_match[0])
  durations_hours = "${local.days * 24}h"
  storage_cmk_key_policy = (
    var.storage_cmk_key_policy.rotation_policy.expire_after != null && var.storage_cmk_key_policy.expiration_date == null
    ? merge(
      var.storage_cmk_key_policy,
      { "expiration_date" : timeadd(timestamp(), local.durations_hours) },
    )
    : var.storage_cmk_key_policy
  )
}
