# tflint-ignore: terraform_required_version

// main.tf

terraform {
  required_version = "~> 1.7"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }
}

# tflint-ignore: terraform_required_providers, terraform_module_version
module "rg" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
