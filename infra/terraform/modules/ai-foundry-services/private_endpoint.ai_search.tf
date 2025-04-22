// private_endpoint.ai_search.tf

resource "azurerm_private_endpoint" "srch" {
  count               = (!var.enable_public_network_access && var.enable_ai_search) ? 1 : 0
  name                = var.ai_search_private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "connection-${azurerm_search_service.this[0].name}"
    private_connection_resource_id = azurerm_search_service.this[0].id
    is_manual_connection           = false
    subresource_names              = [local.ai_search_subresource_name]
  }

  private_dns_zone_group {
    name = "dns-zone-group"
    private_dns_zone_ids = [
      for zone in var.private_dns_zone_ids : zone.id
      if zone.name == "privatelink.search.windows.net"
    ]
  }

  depends_on = [
    azurerm_search_service.this,
  ]
}
