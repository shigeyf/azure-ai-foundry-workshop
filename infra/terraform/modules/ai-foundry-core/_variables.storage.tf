// _variables.storage.tf

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "storage_uami_name" {
  description = "User-assigned Managed Identity name for the Storage"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.storage_uami_name == null)
    error_message = "'storage_uami_name' must be set if 'enable_user_assigned_identity' is enabled."
  }
}

variable "storage_private_endpoint_name" {
  description = "Private Endpoint name for the Storage"
  type        = string
  default     = null
}
