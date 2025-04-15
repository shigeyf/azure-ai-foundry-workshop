// _variables.ai_hub.tf

variable "ai_foundry_hub_name" {
  description = "AI Foundry Hub name"
  type        = string
}

variable "ai_foundry_hub_description" {
  description = "AI Foundry Hub description"
  type        = string
  default     = null
}

variable "ai_foundry_hub_friendly_name" {
  description = "AI Foundry Hub friendly name"
  type        = string
  default     = null
}

variable "high_business_impact_enabled" {
  description = "High business impact enabled"
  type        = bool
  default     = false
}

variable "ai_foundry_hub_uami_name" {
  description = "User-assigned Managed Identity name for the Storage"
  type        = string
}
