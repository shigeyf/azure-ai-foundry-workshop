// variables.tf

variable "location" {
  description = "The location/region where the resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to the resources."
  type        = map(string)
}

variable "unique_suffix" {
  description = "The suffix to append to the resource names."
  type        = string
}

variable "unique_suffix_length" {
  description = "The length of the suffix string to append to the resource names."
  type        = number
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the key vault in which to create the resources."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account in which to create the resources."
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "The name of the log analytics workspace in which to create the resources."
  type        = string

}

variable "application_insights_name" {
  description = "The name of the application insights in which to create the resources."
  type        = string
}

variable "ai_service_name" {
  description = "The name of the AI Service in which to create the resources."
  type        = string
}

variable "ai_service_sku" {
    type        = string
    description = "The sku name of the Azure Analysis Services server to create. Choose from: B1, B2, D1, S0, S1, S2, S3, S4, S8, S9. Some skus are region specific. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region"
    default     = "S0"
}

variable "ai_hub_name" {
  description = "The name of the AI Foundry Hub in which to create the resources."
  type        = string
}
