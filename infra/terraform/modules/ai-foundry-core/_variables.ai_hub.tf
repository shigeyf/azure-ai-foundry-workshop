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

variable "enable_user_assigned_identity" {
  description = "Enable user-assigned identity"
  type        = bool
  default     = false
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
