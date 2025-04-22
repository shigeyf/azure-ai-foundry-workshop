// _variables.tf

variable "private_dns_zones" {
  description = "Private DNS zones to be created"
  type        = list(string)
  default = [
    "privatelink.api.azureml.ms",
    "privatelink.blob.core.windows.net",
    "privatelink.cognitiveservices.azure.com",
    "privatelink.notebooks.azure.net",
    "privatelink.openai.azure.com",
    "privatelink.search.windows.net",
    "privatelink.services.ai.azure.com",
    "privatelink.vaultcore.azure.net",
  ]
}

variable "use_existing_rg" {
  description = "Determine if use the existing resource group"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Existing Resouce Group Name"
  type        = string
  default     = null

  validation {
    condition     = var.use_existing_rg == false || (var.use_existing_rg == true && var.resource_group_name != null)
    error_message = "Resource group name must be provided when use_existing_rg is true."
  }
}

variable "naming_suffix" {
  description = "Naming suffix for the deployed resources"
  type        = list(string)
  default     = ["aifab", "dnszones", "dev"]
}

variable "location" {
  description = "Azure region for the deployment"
  type        = string
  default     = null

  validation {
    condition     = var.use_existing_rg == true || (var.use_existing_rg == false && var.location != null)
    error_message = "Location must be provided when use_existing_rg is false."
  }
}

variable "tags" {
  description = "Tags for the deployment"
  type        = map(string)
  default = {
    envTag     = "dev"
    projectTag = "aifab"
    purposeTag = "dnszones"
  }
}
