// keyvault.tf

module "core_kv" {
  # tflint-ignore: terraform_module_pinned_source
  source = "git::https://github.com/shigeyf/terraform-azurerm-reusables.git//infra/terraform/modules/keyvault?ref=main"

  resource_group_name          = var.resource_group_name
  location                     = var.location
  tags                         = var.tags
  keyvault_name                = var.keyvault_name
  enable_public_network_access = var.enable_public_network_access
  role_assignments             = var.keyvault_role_assignments
  purge_protection_enabled     = var.keyvault_purge_protection_enabled

  private_endpoint_subnet_id = var.private_endpoint_subnet_id
  private_endpoint_name      = var.keyvault_private_endpoint_name
  private_dns_zone_ids = [
    for zone in var.private_dns_zone_ids : zone.id
    if zone.name == "privatelink.vaultcore.azure.net"
  ]
}
