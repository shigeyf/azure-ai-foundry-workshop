// avm.log_analytics_workspace.tf

module "log_analytics_workspace" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "0.4.2"

  name                = local.log_analytics_workspace_name
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}
