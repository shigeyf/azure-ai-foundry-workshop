// main.tf

#
# Private DNS Zones for AI Foundry
#
module "ai_foundry_dns_zones" {
  source          = "../private-dns-zones"
  naming_suffix   = var.dnszone_naming_suffix
  location        = var.location
  tags            = var.dnszone_tags
  use_existing_rg = false
}

#
# Virtual Network for AI Foundry
#
module "ai_foundry_vnet" {
  # tflint-ignore: terraform_module_pinned_source
  source = "git::https://github.com/shigeyf/terraform-azurerm-reusables.git//infra/terraform/modules/vnet?ref=main"

  resource_group_name        = local.resource_group_name
  location                   = local.location
  tags                       = local.tags
  vnet_name                  = local.vnet_name
  nat_gateway_name           = local.nat_gateway_name
  nat_gateway_public_ip_name = local.nat_gateway_public_ip_name
  bastion_name               = local.bastion_host_name
  bastion_public_ip_name     = local.bastion_public_ip_name
  vpn_gateway_name           = local.vpn_gateway_name
  vpn_gateway_public_ip_name = local.vpn_gateway_public_ip_name
  private_dns_zone_names = [
    for zone in module.ai_foundry_dns_zones.private_dns_zone_ids : {
      name                = zone.name,
      resource_group_name = module.ai_foundry_dns_zones.private_dns_zone_rg,
    }
  ]

  // Options
  address_prefix      = var.vnet_address_prefix
  subnets             = var.vnet_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  enable_bastion_host = var.enable_bastion_host
  enable_vpn_gateway  = var.enable_vpn_gateway
}

#
# Core resources and services (Hub, Storage, KeyVault) for AI Foundry
#
module "ai_foundry_hub" {
  source              = "../modules/ai-foundry-core"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  keyvault_name                        = local.keyvault_name
  storage_account_name                 = local.storage_account_name
  storage_cmkey_name                   = local.storage_cmk_key_name
  app_insights_name                    = local.app_insights_name # only if enable_app_insights = true
  ai_foundry_hub_name                  = local.ai_foundry_hub_name
  ai_foundry_hub_description           = local.ai_foundry_hub_name
  ai_foundry_hub_friendly_name         = local.ai_foundry_hub_name
  storage_uami_name                    = local.storage_uami_name
  ai_foundry_hub_uami_name             = local.ai_foundry_hub_uami_name
  keyvault_private_endpoint_name       = local.keyvault_private_endpoint_name
  storage_private_endpoint_name        = local.storage_privete_endpoint_name
  ai_foundry_hub_private_endpoint_name = local.ai_foundry_hub_private_endpoint_name
  private_dns_zone_ids                 = module.ai_foundry_dns_zones.private_dns_zone_ids
  private_endpoint_subnet_id           = module.ai_foundry_vnet.output.subnet_ids[var.vnet_private_endpoint_subnet_name]

  // Options
  enable_app_insights                          = var.enable_app_insights
  high_business_impact_enabled                 = var.enable_ai_foundry_hub_hbi
  ai_foundry_hub_isolation_mode                = var.ai_foundry_hub_isolation_mode
  enable_user_assigned_identity                = var.enable_user_assigned_identity
  enable_both_user_and_system_managed_identity = var.enable_both_user_and_system_managed_identity
  enable_remote_deployment                     = var.enable_remote_deployment
  enable_public_network_access                 = var.enable_public_network_access
  storage_cmkey_policy                         = local.storage_cmk_key_policy
  keyvault_role_assignments = [
    {
      principal_id         = data.azurerm_client_config.current.object_id
      role_definition_name = "Key Vault Administrator"
    },
  ]
}

#
# AI and related services for AI Foundry
#
module "ai_foundry_services" {
  source              = "../modules/ai-foundry-services"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  ai_services_name                  = local.ai_services_name
  ai_search_name                    = local.ai_search_name
  ai_services_uami_name             = local.ai_services_uami_name
  ai_search_uami_name               = local.ai_search_uami_name
  ai_services_private_endpoint_name = local.ai_services_private_endpoint_name
  ai_search_private_endpoint_name   = local.ai_search_private_endpoint_name
  ai_foundry_hub_id                 = module.ai_foundry_hub.output.ai_foundry_hub_id
  ai_foundry_hub_workspace_id       = module.ai_foundry_hub.output.ai_foundry_hub_workspace_id
  ai_foundry_hub_keyvault_id        = module.ai_foundry_hub.output.ai_foundry_hub_keyvault_id
  ai_foundry_hub_storage_id         = module.ai_foundry_hub.output.ai_foundry_hub_storage_id
  ai_foundry_hub_uai_id             = var.enable_user_assigned_identity ? module.ai_foundry_hub.output.ai_foundry_hub_user_assigned_identity : module.ai_foundry_hub.output.ai_foundry_hub_managed_identity
  private_endpoint_subnet_id        = module.ai_foundry_vnet.output.subnet_ids[var.vnet_private_endpoint_subnet_name]
  private_dns_zone_ids              = module.ai_foundry_dns_zones.private_dns_zone_ids

  // Options
  ai_services_sku                              = var.ai_services_sku
  enable_ai_search                             = var.enable_ai_search
  ai_search_sku                                = var.ai_search_sku
  enable_user_assigned_identity                = var.enable_user_assigned_identity
  enable_both_user_and_system_managed_identity = var.enable_both_user_and_system_managed_identity
  enable_public_network_access                 = var.enable_public_network_access

  depends_on = [
    null_resource.main_temporary_unlock_kv,
  ]
}

#
# A Project resource for AI Foundry
#
module "ai_foundry_project" {
  source              = "../modules/ai-foundry-project"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  ai_foundry_project_name      = local.ai_foundry_project_name
  ai_foundry_project_uami_name = local.ai_foundry_project_uami_name
  ai_foundry_hub_id            = module.ai_foundry_hub.output.ai_foundry_hub_id
  ai_foundry_hub_storage_id    = module.ai_foundry_hub.output.ai_foundry_hub_storage_id
  ai_foundry_hub_keyvault_id   = module.ai_foundry_hub.output.ai_foundry_hub_keyvault_id

  // Options
  enable_user_assigned_identity                = var.enable_user_assigned_identity
  enable_both_user_and_system_managed_identity = var.enable_both_user_and_system_managed_identity

  depends_on = [
    null_resource.main_temporary_unlock_kv,
  ]
}
