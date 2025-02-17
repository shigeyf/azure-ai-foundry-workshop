// modules/*/variables.tf

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

variable "storage_account_name" {
  description = "The name of the storage account in which to create the resources."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the key vault in which to create the resources."
  type        = string
}
