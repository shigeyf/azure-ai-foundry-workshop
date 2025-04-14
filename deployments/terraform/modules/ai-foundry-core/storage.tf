// storage.tf

module "core_storage" {
  # tflint-ignore: terraform_module_pinned_source
  source = "git::https://github.com/shigeyf/terraform-azurerm-reusables.git//infra/terraform/modules/storage?ref=main"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  storage_account_name    = var.storage_account_name
  storage_uami_name       = var.storage_uami_name
  keyvault_id             = module.core_kv.output.keyvault_id
  customer_managed_key_id = module.core_storage_cmkey.output.key_versionless_id

  enable_public_network_access = var.enable_public_network_access
  private_endpoint_subnet_id   = var.private_endpoint_subnet_id
  private_endpoint_name        = var.storage_private_endpoint_name
}
