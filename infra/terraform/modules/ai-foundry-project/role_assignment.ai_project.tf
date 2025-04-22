// role_assignment.ai_project.tf

//
// Role Assignments for AI Foundry Project Identity
//

locals {
  _st_roles = [
    "Reader",
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    "Storage File Data Privileged Contributor",
    "Storage Table Data Contributor",
  ]
  _kv_roles = [
    "Contributor",
    "Key Vault Administrator",
  ]
  _self_roles = [
    "Azure AI Administrator",
  ]
}

resource "azurerm_role_assignment" "proj_uai_ra_st" {
  for_each             = var.enable_user_assigned_identity ? toset(local._st_roles) : []
  scope                = var.ai_foundry_hub_storage_id
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
  role_definition_name = each.value

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}

resource "azurerm_role_assignment" "proj_uai_ra_kv" {
  for_each             = var.enable_user_assigned_identity ? toset(local._kv_roles) : []
  scope                = var.ai_foundry_hub_keyvault_id
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
  role_definition_name = each.value

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}

# This resource is used to ensure that the role assignment is created after the Key Vault is created.
resource "time_sleep" "ra_propagation_delay" {
  count           = var.enable_user_assigned_identity ? 1 : 0
  create_duration = "60s"
  depends_on = [
    azurerm_user_assigned_identity.this,
    azurerm_role_assignment.proj_uai_ra_st,
    azurerm_role_assignment.proj_uai_ra_kv,
  ]
}

resource "azurerm_role_assignment" "proj_uai_ra_self" {
  for_each             = var.enable_user_assigned_identity ? toset(local._self_roles) : []
  scope                = azapi_resource.this.id
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
  role_definition_name = each.value

  depends_on = [
    azapi_resource.this,
    azurerm_user_assigned_identity.this,
  ]
}
