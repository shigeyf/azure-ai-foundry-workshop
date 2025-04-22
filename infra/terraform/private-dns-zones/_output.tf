// _output.tf

output "private_dns_zone_rg" {
  description = "The resource group name of the private DNS zones."
  value       = local.resource_group_name
}

output "private_dns_zone_ids" {
  description = "The Ids of the private DNS zones."
  value       = { for index, zone in azurerm_private_dns_zone.this : zone.name => [zone.id] }
}
