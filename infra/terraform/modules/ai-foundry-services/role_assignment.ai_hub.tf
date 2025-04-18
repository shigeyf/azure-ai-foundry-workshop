// role_assignment.ai_hub.tf

//
// Role Assignments for AI Foundry Project Identity
//

resource "azurerm_role_assignment" "hub_uai_ra_ais" {
  scope                = azurerm_ai_services.this.id
  principal_id         = var.ai_foundry_hub_uai_id
  role_definition_name = "Contributor"

  depends_on = [
    azurerm_ai_services.this,
  ]
}
