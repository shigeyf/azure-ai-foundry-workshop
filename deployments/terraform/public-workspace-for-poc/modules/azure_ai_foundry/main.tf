// modules/*/main.tf

module "rg" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
