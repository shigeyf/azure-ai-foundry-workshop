// main.tf

module "ai_foundry_hub" {
  source              = "../modules/ai-foundry-core"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  keyvault_role_assignments = [
    {
      principal_id         = data.azurerm_client_config.current.object_id
      role_definition_name = "Key Vault Administrator"
    },
  ]
  keyvault_name        = local.keyvault_name
  storage_account_name = local.storage_account_name
  storage_cmkey_name   = local.storage_cmk_key_name
  storage_cmkey_policy = var.storage_cmk_key_policy
  enable_app_insights  = var.enable_app_insights # whether to enable Application Insights
  app_insights_name    = local.app_insights_name # only if enable_app_insights = true

  ai_foundry_hub_name              = local.ai_foundry_hub_name
  ai_foundry_hub_description       = local.ai_foundry_hub_name
  ai_foundry_hub_friendly_name     = local.ai_foundry_hub_name
  high_business_impact_enabled     = var.enable_ai_foundry_hub_hbi        # whether to enable high business impact
  enable_ai_foundry_hub_encryption = var.enable_ai_foundry_hub_encryption # whether to enable encryption for the AI Hub
  ai_foundry_hub_cmkey_name        = local.ai_foundry_hub_cmk_key_name    # only if enable_ai_foundry_hub_encryption = true
  ai_foundry_hub_cmkey_policy      = var.storage_cmk_key_policy           # only if enable_ai_foundry_hub_encryption = true

  enable_user_assigned_identity = var.enable_user_assigned_identity # whether to enable user-assigned managed identity
  storage_uami_name             = local.storage_uami_name           # only if enable_user_assigned_identity = true
  ai_foundry_hub_uami_name      = local.ai_foundry_hub_uami_name    # only if enable_user_assigned_identity = true

  enable_public_network_access = var.enable_public_network_access
}

module "ai_foundry_services" {
  source              = "../modules/ai-foundry-services"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  ai_services_name            = local.ai_services_name
  ai_services_sku             = var.ai_services_sku
  ai_foundry_hub_id           = module.ai_foundry_hub.output.ai_foundry_hub_id
  ai_foundry_hub_workspace_id = module.ai_foundry_hub.output.ai_foundry_hub_workspace_id
  ai_foundry_hub_keyvault_id  = module.ai_foundry_hub.output.ai_foundry_hub_keyvault_id

  enable_user_assigned_identity = var.enable_user_assigned_identity
  ai_services_uami_name         = local.ai_services_uami_name

  enable_public_network_access = var.enable_public_network_access
}

module "ai_foundry_project" {
  source              = "../modules/ai-foundry-project"
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  ai_foundry_project_name = local.ai_foundry_project_name
  ai_foundry_hub_id       = module.ai_foundry_hub.output.ai_foundry_hub_id

  enable_user_assigned_identity = var.enable_user_assigned_identity
  ai_foundry_project_uami_name  = local.ai_foundry_project_uami_name
}
