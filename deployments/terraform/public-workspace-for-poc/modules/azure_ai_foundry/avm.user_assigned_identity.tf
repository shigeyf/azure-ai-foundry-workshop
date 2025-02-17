//

module "user_assigned_identity_for_storage" {
  source = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  // version = "0.3.3"

  name                = local.uami_name_for_storage
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}
