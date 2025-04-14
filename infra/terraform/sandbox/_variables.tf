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

variable "enable_public_network_access" {
  description = "Enable public network access for the AI Foundry resources"
  type        = bool
  default     = true
}

variable "storage_cmk_key_policy" {
  description = "Key policy for the customer managed key"
  type = object({
    key_type   = string
    key_size   = optional(number, 2048)
    curve_type = optional(string)

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
