// _variables_ai_search.tf

variable "enable_ai_search" {
  description = "Enable Azure AI Search service"
  type        = bool
  default     = false
}

variable "ai_search_name" {
  description = "AI Search service name"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_ai_search && var.ai_search_name == null)
    error_message = "'ai_search_name' must be set if 'enable_ai_search' is enabled."
  }
}

variable "ai_search_sku" {
  description = "The SKU of the Azure AI Search service."
  type        = string
  default     = "standard"
  // Possible values include basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2
}

variable "ai_search_semantic_search_sku" {
  description = "The SKU of the Azure AI Search service for semantic search."
  type        = string
  default     = null
  // Possible values include free and standard
  // The semantic_search_sku cannot be defined if your Search Services sku is set to free.
  // The Semantic Search feature is only available in certain regions.
  // Please see the product documentation for more information.
}

variable "ai_search_hosting_mode" {
  description = "The hosting mode of the Azure AI Search service for High Density partitions (that allow for up to 1000 indexes) should be supported"
  type        = string
  default     = "default"
  // Possible values include highDensity and default
  // ai_search_hosting_mode can only be configured when sku is set to standard3
}

variable "ai_search_partition_count" {
  description = "The number of partitions for the Azure AI Search service. This field cannot be set when using a free sku."
  type        = number
  default     = 1
  // Possible values include 1, 2, 3, 4, 6, or 12. Defaults to 1.
  // When hosting_mode is set to highDensity the maximum number of partitions allowed is 3.
}

variable "ai_search_replica_count" {
  description = "The number of replicas for the Azure AI Search service. This field cannot be set when using a free sku."
  type        = number
  default     = 1
}

variable "ai_search_customer_managed_key_enforcement_enabled" {
  description = "Specifies whether the Search Service should enforce that non-customer resources are encrypted"
  type        = bool
  default     = false
}

variable "ai_search_uami_name" {
  description = "User-assigned Managed Identity name for the AI Search service"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.ai_search_uami_name == null)
    error_message = "'ai_search_uami_name' must be set if 'enable_user_assigned_identity' is enabled."
  }
}

variable "ai_search_private_endpoint_name" {
  description = "Private Endpoint name for the AI Search service"
  type        = string
  default     = null

  validation {
    condition     = !(!var.enable_public_network_access && var.ai_search_private_endpoint_name == null)
    error_message = "'ai_search_private_endpoint_name' must be set if 'enable_public_network_access' is disabled."
  }
}
