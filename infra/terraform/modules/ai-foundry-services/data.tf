// data.tf

data "azurerm_resource_group" "target" {
  name = var.resource_group_name
}
