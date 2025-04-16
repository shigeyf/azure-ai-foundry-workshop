// _variables.ai_hub_cmk.tf

variable "ai_foundry_hub_cmkey_name" {
  description = "CMK name for AI Foundry Hub"
  type        = string
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
}
