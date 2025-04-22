// private_endpoint.ai_services.tf

resource "azurerm_private_endpoint" "ais" {
  count               = (!var.enable_public_network_access) ? 1 : 0
  name                = var.ai_services_private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "connection-${azurerm_ai_services.this.name}"
    private_connection_resource_id = azurerm_ai_services.this.id
    is_manual_connection           = false
    subresource_names              = [local.ai_services_subresource_name]
  }

  private_dns_zone_group {
    name = "dns-zone-group"
    private_dns_zone_ids = [
      for zone in var.private_dns_zone_ids : zone.id
      if zone.name == "privatelink.cognitiveservices.azure.com"
      || zone.name == "privatelink.openai.azure.com"
      || zone.name == "privatelink.services.ai.azure.com"
    ]
  }

  depends_on = [
    azurerm_ai_services.this,
  ]
}
