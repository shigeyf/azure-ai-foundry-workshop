// _locals.tf

// enable_both_user_and_system_managed_identity is true:
//  - enable_user_assigned_identity is true:  "SystemAssigned, UserAssigned"
//  - enable_user_assigned_identity is false: "SystemAssigned"
// enable_both_user_and_system_managed_identity is false:
//  - enable_user_assigned_identity is true:  "UserAssigned"
//  - enable_user_assigned_identity is false: "SystemAssigned"

locals {
  identity_type = (
    var.enable_user_assigned_identity
    ? (var.enable_both_user_and_system_managed_identity ? "SystemAssigned, UserAssigned" : "UserAssigned")
    : "SystemAssigned"
  )
  //use_managed_identity       = !(!var.enable_both_user_and_system_managed_identity && var.enable_user_assigned_identity)
  use_user_assigned_identity = var.enable_user_assigned_identity
}
