// rg.tf

data "azurerm_resource_group" "rg" {
  count = var.use_existing_rg ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.use_existing_rg ? 0 : 1
  name     = local.create_resource_group_name
  location = var.location
  tags     = var.tags
}
