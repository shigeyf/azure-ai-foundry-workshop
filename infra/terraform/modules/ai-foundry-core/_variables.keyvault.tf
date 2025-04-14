// _variables.keyvault.tf

variable "keyvault_name" {
  description = "Key Vault name"
  type        = string
}

variable "keyvault_purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault"
  type        = bool
  default     = true
}

variable "keyvault_role_assignments" {
  description = "Role assignments for the Key Vault"
  type = list(object({
    principal_id         = string
    role_definition_name = string
  }))
  default = []
}

variable "keyvault_private_endpoint_name" {
  description = "Private Endpoint name for the Key Vault"
  type        = string
  default     = null
}
