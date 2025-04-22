// _variables.ai_services.tf

variable "ai_services_name" {
  description = "AI Services name"
  type        = string
}

variable "ai_services_sku" {
  description = "AI Services SKU"
  type        = string
  default     = "S0"
}

variable "ai_services_uami_name" {
  description = "User-assigned Managed Identity name for the AI Services"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.ai_services_uami_name == null)
    error_message = "'ai_services_uami_name' must be set if 'enable_user_assigned_identity' is enabled."
  }
}

variable "ai_services_private_endpoint_name" {
  description = "Private Endpoint name for the AI Services"
  type        = string
  default     = null

  validation {
    condition     = !(!var.enable_public_network_access && var.ai_services_private_endpoint_name == null)
    error_message = "'ai_services_private_endpoint_name' must be set if 'enable_public_network_access' is disabled."
  }
}
