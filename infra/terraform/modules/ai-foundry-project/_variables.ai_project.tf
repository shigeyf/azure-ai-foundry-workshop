// _variables.ai_project.tf

variable "ai_foundry_project_name" {
  description = "AI Foundry Project name"
  type        = string
}

variable "ai_foundry_project_description" {
  description = "AI Foundry Project description"
  type        = string
  default     = null
}

variable "ai_foundry_project_friendly_name" {
  description = "AI Foundry Project friendly name"
  type        = string
  default     = null
}

variable "ai_foundry_hub_id" {
  description = "AI Foundry Hub Id"
  type        = string
}

variable "high_business_impact_enabled" {
  description = "High business impact enabled"
  type        = bool
  default     = false
}

variable "ai_foundry_project_uami_name" {
  description = "User-assigned Managed Identity name for the Storage"
  type        = string
}
