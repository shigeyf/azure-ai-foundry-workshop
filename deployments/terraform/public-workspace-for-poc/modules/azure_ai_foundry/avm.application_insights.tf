// avm.application_insights.tf

module "application_insights" {
  source  = "Azure/avm-res-insights-component/azurerm"
  version = "0.1.5"

  // Basic properties
  name                = local.application_insights_name
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  tags                = var.tags

  // Advanced properties
  application_type  = "web"
  retention_in_days = 90
  workspace_id      = module.log_analytics_workspace.resource_id

  depends_on = [
    module.log_analytics_workspace,
  ]
}
