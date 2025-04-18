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

variable "ai_foundry_hub_id" {
  description = "AI Foundry Hub Id"
  type        = string
}

variable "ai_foundry_hub_keyvault_id" {
  description = "AI Foundry Hub Key Vault Id"
  type        = string
}

variable "ai_foundry_hub_storage_id" {
  description = "Storage Account Id for AI Foundry hub"
  type        = string
}
