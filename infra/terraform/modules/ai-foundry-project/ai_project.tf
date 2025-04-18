// ai_project.tf

# Currently, Terraform azurerm provider does not support user_assigned identity for AI Foundry Project.
# We use azapi_resource to create the AI Foundry Project instead.

# resource "azurerm_ai_foundry_project" "this" {
#   name     = var.ai_foundry_project_name
#   location = var.location
#   tags     = var.tags
#
#   description = (
#     var.ai_foundry_project_description == null
#     ? var.ai_foundry_project_name
#     : var.ai_foundry_project_description
#   )
#   friendly_name = (
#     var.ai_foundry_project_friendly_name == null
#     ? var.ai_foundry_project_name
#     : var.ai_foundry_project_friendly_name
#   )
#   ai_services_hub_id           = var.ai_foundry_hub_id
#   high_business_impact_enabled = var.high_business_impact_enabled
#
#   # Enable system-assigned managed identity
#   #primary_user_assigned_identity = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].id : null
#   identity {
#     type         = local.identity_type
#     identity_ids = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.this[0].id] : []
#   }
#
#   depends_on = [
#     azurerm_user_assigned_identity.this,
#   ]
# }

# Currently, Terraform azurerm provider does not support user_assigned identity for AI Foundry Project.
data "azurerm_resource_group" "target" {
  name = var.resource_group_name
}

resource "azapi_resource" "this" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-10-01"
  name      = var.ai_foundry_project_name
  location  = var.location
  parent_id = data.azurerm_resource_group.target.id

  # Enable system-assigned managed identity
  identity {
    type         = local.identity_type
    identity_ids = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.this[0].id] : []
  }

  body = {
    kind = "project"
    properties = {
      description                 = var.ai_foundry_project_description == null ? var.ai_foundry_project_name : var.ai_foundry_project_description
      friendlyName                = var.ai_foundry_project_friendly_name == null ? var.ai_foundry_project_name : var.ai_foundry_project_friendly_name
      hubResourceId               = var.ai_foundry_hub_id
      primaryUserAssignedIdentity = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].id : null
      hbiWorkspace                = var.high_business_impact_enabled
    }
  }

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}
