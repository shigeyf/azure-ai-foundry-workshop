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

variable "ai_foundry_hub_id" {
  description = "AI Foundry Hub Id"
  type        = string
}

variable "ai_foundry_hub_workspace_id" {
  description = "AI Foundry Hub Workspace Id"
  type        = string
}

variable "ai_foundry_hub_keyvault_id" {
  description = "AI Foundry Hub Key Vault Id"
  type        = string
}

variable "enable_user_assigned_identity" {
  description = "Enable user-assigned identity"
  type        = bool
  default     = false
}

variable "ai_services_uami_name" {
  description = "User-assigned Managed Identity name for the AI Sergvices"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.ai_services_uami_name == null)
    error_message = "'ai_services_uami_name' must be set if 'enable_user_assigned_identity' is enabled."
  }
}

variable "ai_foundry_hub_storage_id" {
  description = "Storage Account Id for AI Foundry hub"
  type        = string
}
