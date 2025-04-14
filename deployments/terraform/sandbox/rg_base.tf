// rg_base.tf

resource "azurerm_resource_group" "base" {
  name     = local.create_resource_group_name
  location = local.location
  tags     = local.tags
}
