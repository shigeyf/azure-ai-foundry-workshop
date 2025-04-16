// _variables.app_insights.tf

variable "enable_app_insights" {
  description = "Enable Application Insights"
  type        = bool
  default     = false
}

variable "app_insights_name" {
  description = "Application Insights name"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_app_insights && var.app_insights_name == null)
    error_message = "'app_insights_name' must be set if 'enable_app_insights' is enabled."
  }
}

variable "enable_app_insights_workspace" {
  description = "Enable Application Insights workspace"
  type        = bool
  default     = false
}

variable "app_insights_workspace_id" {
  description = "Log Analytics Workspace Id for Application Insights"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_app_insights && var.enable_app_insights_workspace && var.app_insights_workspace_id == null)
    error_message = "'app_insights_workspace_id' must be set if both 'enable_app_insights' and 'enable_app_insights_workspace' is enabled."
  }
}

variable "appi_daily_data_cap_in_gb" {
  description = "Application Insights component daily data volume cap in GB"
  type        = number
  default     = 100
}

variable "appi_daily_data_cap_notifications_disabled" {
  description = "Disable daily data cap notifications"
  type        = bool
  default     = false
}

variable "appi_retention_in_days" {
  description = "Retention period in days"
  type        = number
  default     = 90
  // Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730.
}

variable "appi_sampling_percentage" {
  description = "Sampling percentage for Application Insights telemetry"
  type        = number
  default     = 100
}

variable "appi_disable_ip_masking" {
  description = "Disable IP masking in Application Insights logs"
  type        = bool
  default     = false
}
