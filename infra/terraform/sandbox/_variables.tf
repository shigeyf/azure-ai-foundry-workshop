// _variables.tf

variable "naming_suffix" {
  description = "Naming suffix for the deployed resources"
  type        = list(string)
  default     = ["aifab", "sandbox", "dev"]
}

variable "location" {
  description = "Azure region for the deployment"
  type        = string
}

variable "tags" {
  description = "Tags for the deployment"
  type        = map(string)
  default = {
    envTag     = "dev"
    projectTag = "aifab"
    purposeTag = "sandbox"
  }
}

variable "enable_user_assigned_identity" {
  description = "Enable user-assigned identity for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "enable_public_network_access" {
  description = "Enable public network access for the AI Foundry resources"
  type        = bool
  default     = true
}

variable "enable_ai_foundry_hub_hbi" {
  description = "Enable high business impact for the AI Foundry Hub"
  type        = bool
  default     = false
}

variable "enable_app_insights" {
  description = "Enable Application Insights for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "storage_cmk_key_policy" {
  description = "Key policy for the customer managed key"
  type = object({
    key_type        = string
    key_size        = optional(number, 2048)
    curve_type      = optional(string)
    expiration_date = optional(string, null) # this module has a logic to set the expiration date from 'expire_after' value
    rotation_policy = optional(object({
      automatic = optional(object({
        time_after_creation = optional(string)
        time_before_expiry  = optional(string, "P30D")
      }))
      expire_after         = optional(string, "P30D")
      notify_before_expiry = optional(string, "P29D")
    }))
  })
}

variable "ai_services_sku" {
  description = "SKU for the AI Foundry's AI Services resource"
  type        = string
  default     = "S0"
}

variable "enable_ai_search" {
  description = "Enable AI Search for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "ai_search_sku" {
  description = "SKU for the AI Search resource"
  type        = string
  default     = "standard"
}
