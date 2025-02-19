// avm.user_assigned_identity_aihub.tf

module "user_assigned_identity_for_aihub" {
  source  = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version = "0.3.3"

  name                = local.uami_name_for_aihub
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  tags                = var.tags
}
