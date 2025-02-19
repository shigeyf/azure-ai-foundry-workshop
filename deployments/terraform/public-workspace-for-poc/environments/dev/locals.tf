// envs/dev/locals.tf

// Define resource names according to the Azure naming conventions.
locals {
  resource_group_name          = module.global.naming.resource_group.name
  storage_account_name         = module.global.naming.storage_account.name
  key_vault_name               = module.global.naming.key_vault.name
  log_analytics_workspace_name = module.global.naming.log_analytics_workspace.name
  application_insights_name    = module.global.naming.application_insights.name
  ai_service_name              = "ais-${var.project}-${var.environment}-${var.location}"
  ai_hub_name                  = "hub-${var.project}-${var.environment}-${var.location}"
}
