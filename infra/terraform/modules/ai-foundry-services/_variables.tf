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

variable "ai_foundry_hub_workspace_id" {
  description = "AI Foundry Hub Workspace Id"
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

variable "ai_foundry_hub_uai_id" {
  description = "AI Foundry Hub User Assigned Identity Id"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.ai_foundry_hub_uai_id == null)
    error_message = "'ai_foundry_hub_uai_id' must be set if 'enable_user_assigned_identity' is enabled."
  }
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

variable "private_dns_zone_ids" {
  type = list(object(
    {
      name = string
      id   = string
    }
  ))
  description = "Map object of list of Private DNS Zone Id"
  default     = []
}
