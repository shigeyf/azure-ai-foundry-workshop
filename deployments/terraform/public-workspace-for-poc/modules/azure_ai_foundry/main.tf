# tflint-ignore: terraform_required_version

// modules/*/main.tf

# tflint-ignore: terraform_required_providers, terraform_module_version
module "rg" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
