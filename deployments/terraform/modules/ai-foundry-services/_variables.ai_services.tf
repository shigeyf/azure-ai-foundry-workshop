// _variables.ai_services.tf

variable "ai_services_name" {
  description = "AI Services name"
  type        = string
}

variable "ai_services_sku" {
  description = "AI Services SKU"
  type        = string
  default     = "S0"
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
