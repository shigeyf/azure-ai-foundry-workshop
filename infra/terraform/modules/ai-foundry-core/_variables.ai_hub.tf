// _variables.ai_hub.tf

variable "ai_foundry_hub_name" {
  description = "AI Foundry Hub name"
  type        = string
}

variable "ai_foundry_hub_description" {
  description = "AI Foundry Hub description"
  type        = string
  default     = null
}

variable "ai_foundry_hub_friendly_name" {
  description = "AI Foundry Hub friendly name"
  type        = string
  default     = null
}

variable "high_business_impact_enabled" {
  description = "High business impact enabled"
  type        = bool
  default     = false
}

variable "enable_ai_foundry_hub_encryption" {
  description = "Enable encryption for AI Foundry Hub"
  type        = bool
  default     = false
}

variable "ai_foundry_hub_isolation_mode" {
  description = "The isolation mode of the AI Foundry Hub: Possible values are Disabled, AllowOnlyApprovedOutbound, and AllowInternetOutbound"
  type        = string
  default     = "Disabled"
}

variable "ai_foundry_hub_uami_name" {
  description = "User-assigned Managed Identity name for the AI Foundry Hub"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.ai_foundry_hub_uami_name == null)
    error_message = "'ai_foundry_hub_uami_name' must be set if 'enable_user_assigned_identity' is enabled."
  }
}

variable "ai_foundry_hub_private_endpoint_name" {
  description = "Private Endpoint name for the AI Foundry Hub"
  type        = string
  default     = null

  validation {
    condition     = !(!var.enable_public_network_access && var.ai_foundry_hub_private_endpoint_name == null)
    error_message = "'ai_foundry_hub_private_endpoint_name' must be set if 'enable_public_network_access' is disabled."
  }
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of Private DNS Zone Id"
  default     = []
}
