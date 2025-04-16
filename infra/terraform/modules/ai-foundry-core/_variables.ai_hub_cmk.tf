// _variables.ai_hub_cmk.tf

variable "ai_foundry_hub_cmkey_name" {
  description = "CMK name for AI Foundry Hub"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_ai_foundry_hub_encryption && var.ai_foundry_hub_cmkey_name == null)
    error_message = "'ai_foundry_hub_cmkey_name' must be set if 'enable_ai_foundry_hub_encryption' is enabled."
  }
}

variable "ai_foundry_hub_cmkey_policy" {
  description = "Key policy for the AI Foundry Hub CMK"
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
  default = null

  validation {
    condition     = !(var.enable_ai_foundry_hub_encryption && var.ai_foundry_hub_cmkey_policy == null)
    error_message = "'ai_foundry_hub_cmkey_policy' must be set if 'enable_ai_foundry_hub_encryption' is enabled."
  }
}
