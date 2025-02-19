//

resource "azapi_resource" "AIServicesResource" {
  type = "Microsoft.CognitiveServices/accounts@2023-10-01-preview"

  // Basic properties
  name      = local.ai_service_name
  location  = local.resource_group_location
  parent_id = local.resource_group_id
  tags      = var.tags

  identity {
    type = "SystemAssigned"
  }

  // API Request Body
  body = {
    name = local.ai_service_name
    properties = {
      customSubDomainName = "${local.ai_service_name}-domain"
      publicNetworkAccess = "Enabled"
    }
    kind = "AIServices"
    sku = {
      name = var.ai_service_sku
    }
  }

  response_export_values = ["*"]
}
