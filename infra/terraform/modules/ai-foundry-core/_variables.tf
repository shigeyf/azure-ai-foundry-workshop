// variables.tf

variable "location" {
  type        = string
  description = "Resource location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "enable_user_assigned_identity" {
  description = "Enable user-assigned identity"
  type        = bool
  default     = false
}

variable "enable_both_user_and_system_managed_identity" {
  description = "Enable both user-assigned and system managed identities"
  type        = bool
  default     = false
}

variable "enable_public_network_access" {
  description = "Enable public network access for the Key Vault"
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
  default     = null
}

variable "enable_remote_deployment" {
  description = "Enable remote deployment for the Key Vault Keys"
  type        = bool
  default     = false
}
