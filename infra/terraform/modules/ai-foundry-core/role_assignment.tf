// role_assignment.tf

//
// Role Assignments for AI Foundry Hub Identity
//

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

// Resource Group: Contributor
resource "azurerm_role_assignment" "hub_uai_ra_rg" {
  count                = local.use_user_assigned_identity ? 1 : 0
  scope                = data.azurerm_resource_group.rg.id
  principal_id         = azurerm_user_assigned_identity.hub[0].principal_id
  role_definition_name = "Contributor"

  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_user_assigned_identity.hub,
  ]
}

// Storage: Storage Blob Data Contributor
resource "azurerm_role_assignment" "hub_uai_ra_st1" {
  count                = local.use_user_assigned_identity ? 1 : 0
  scope                = module.core_storage.output.storage_id
  principal_id         = azurerm_user_assigned_identity.hub[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"

  depends_on = [
    module.core_storage,
    azurerm_user_assigned_identity.hub,
  ]
}

// Storage: Storage File Data Privileged Contributor
resource "azurerm_role_assignment" "hub_uai_ra_st2" {
  count                = local.use_user_assigned_identity ? 1 : 0
  scope                = module.core_storage.output.storage_id
  principal_id         = azurerm_user_assigned_identity.hub[0].principal_id
  role_definition_name = "Storage File Data Privileged Contributor"

  depends_on = [
    module.core_storage,
    azurerm_user_assigned_identity.hub,
  ]
}

// Key Vault: Key Vault Administrator
resource "azurerm_role_assignment" "hub_uai_ra_kv" {
  count                = local.use_user_assigned_identity ? 1 : 0
  scope                = module.core_kv.output.keyvault_id
  principal_id         = azurerm_user_assigned_identity.hub[0].principal_id
  role_definition_name = "Key Vault Administrator"

  depends_on = [
    module.core_kv,
    azurerm_user_assigned_identity.hub,
  ]
}

# This resource is used to ensure that the role assignment is created after the Key Vault is created.
resource "time_sleep" "wait_for_ra_propagation" {
  count           = var.enable_user_assigned_identity ? 1 : 0
  create_duration = "60s"
  depends_on = [
    azurerm_user_assigned_identity.hub,
    azurerm_role_assignment.hub_uai_ra_rg,
    azurerm_role_assignment.hub_uai_ra_st1,
    azurerm_role_assignment.hub_uai_ra_st2,
    azurerm_role_assignment.hub_uai_ra_kv,
  ]
}

// AI Foundry Hub: Azure AI Administrator
resource "azurerm_role_assignment" "hub_uai_ra_self" {
  count                = local.use_user_assigned_identity ? 1 : 0
  scope                = azurerm_ai_foundry.this.id
  principal_id         = azurerm_user_assigned_identity.hub[0].principal_id
  role_definition_name = "Azure AI Administrator"

  depends_on = [
    azurerm_ai_foundry.this,
    azurerm_user_assigned_identity.hub,
  ]
}
