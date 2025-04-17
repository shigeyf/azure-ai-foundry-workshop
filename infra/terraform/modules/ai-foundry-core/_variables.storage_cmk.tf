// _variables.storage_cmk.tf

variable "storage_cmkey_name" {
  description = "CMK name for Storage account"
  type        = string
}

variable "storage_cmkey_policy" {
  description = "Key policy for the Storage CMK"
  type = object({
    key_type        = string
    key_size        = optional(number, 2048)
    curve_type      = optional(string)
    expiration_date = optional(string, null)
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
