// _variables.tf

variable "dnszone_naming_suffix" {
  description = "Naming suffix for the deployed resources"
  type        = list(string)
  default     = ["aihub", "enterprise", "prod"]
}

variable "dnszone_tags" {
  description = "Tags for the deployment"
  type        = map(string)
  default = {
    envTag     = "prod"
    projectTag = "dns"
    purposeTag = "enterprise"
  }
}

variable "naming_suffix" {
  description = "Naming suffix for the deployed resources"
  type        = list(string)
  default     = ["aihub", "enterprise", "prod"]
}

variable "location" {
  description = "Azure region for the deployment"
  type        = string
}

variable "tags" {
  description = "Tags for the deployment"
  type        = map(string)
  default = {
    envTag     = "prod"
    projectTag = "aihub"
    purposeTag = "enterprise"
  }
}

variable "enable_user_assigned_identity" {
  description = "Enable user-assigned identity for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "enable_both_user_and_system_managed_identity" {
  description = "Enable both user-assigned and system managed identities"
  type        = bool
  default     = false
}

variable "enable_remote_deployment" {
  description = "Enable remote deployment for the Key Vault Keys"
  type        = bool
  default     = false
}

variable "enable_public_network_access" {
  description = "Enable public network access for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "ai_foundry_hub_isolation_mode" {
  description = "The isolation mode of the AI Foundry Hub: Possible values are Disabled, AllowOnlyApprovedOutbound, and AllowInternetOutbound"
  type        = string
  default     = "Disabled"
}

variable "enable_ai_foundry_hub_hbi" {
  description = "Enable high business impact for the AI Foundry Hub"
  type        = bool
  default     = false
}

variable "enable_app_insights" {
  description = "Enable Application Insights for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "storage_cmk_key_policy" {
  description = "Key policy for the customer managed key"
  type = object({
    key_type        = string
    key_size        = optional(number, 2048)
    curve_type      = optional(string)
    expiration_date = optional(string, null) # this module has a logic to set the expiration date from 'expire_after' value
    rotation_policy = optional(object({
      automatic = optional(object({
        time_after_creation = optional(string)
        time_before_expiry  = optional(string, "P30D")
      }))
      expire_after         = optional(string, "P30D")
      notify_before_expiry = optional(string, "P29D")
    }))
  })
}

variable "ai_services_sku" {
  description = "SKU for the AI Foundry's AI Services resource"
  type        = string
  default     = "S0"
}

variable "enable_ai_search" {
  description = "Enable AI Search for the AI Foundry resources"
  type        = bool
  default     = false
}

variable "ai_search_sku" {
  description = "SKU for the AI Search resource"
  type        = string
  default     = "standard"
}

variable "vnet_address_prefix" {
  description = "Address prefix for the virtual network"
  type        = string
}

variable "vnet_private_endpoint_subnet_name" {
  description = "Subnet name for the private endpoints in the virtual network"
  type        = string
}

variable "vnet_subnets" {
  description = "Subnets configurations for the virtual network"
  type = map(object(
    {
      name                  = string    # Subnet name
      address_prefix        = string    # Subnet address prefix
      naming_prefix_enabled = bool      # Whether to add naming prefix ("snet") to the subnet name
      delegation = optional(set(object( # 'delegation' block
        {
          name = string
          service_delegation = object(
            {
              name    = string
              actions = optional(list(string))
            }
          )
        }
      )))
    }
  ))
  default = {}
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway for the virtual network"
  type        = bool
  default     = false
}

variable "enable_bastion_host" {
  description = "Enable Bastion host for the virtual network"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Enable VPN gateway for the virtual network"
  type        = bool
  default     = false
}
