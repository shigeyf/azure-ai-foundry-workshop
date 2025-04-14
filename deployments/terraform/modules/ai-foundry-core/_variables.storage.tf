// _variables.storage.tf

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "storage_uami_name" {
  description = "User-assigned Managed Identity name for the Storage"
  type        = string
}

variable "storage_private_endpoint_name" {
  description = "Private Endpoint name for the Storage"
  type        = string
  default     = null
}
