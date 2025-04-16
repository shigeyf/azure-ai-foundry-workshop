// app_insights.tf

resource "azurerm_application_insights" "this" {
  count               = var.enable_app_insights ? 1 : 0
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  application_type                      = "web"
  daily_data_cap_in_gb                  = var.appi_daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.appi_daily_data_cap_notifications_disabled
  retention_in_days                     = var.appi_retention_in_days
  sampling_percentage                   = var.appi_sampling_percentage
  disable_ip_masking                    = var.appi_disable_ip_masking
  workspace_id = (
    var.enable_app_insights && var.enable_app_insights_workspace ? var.app_insights_workspace_id : null
  )
}
