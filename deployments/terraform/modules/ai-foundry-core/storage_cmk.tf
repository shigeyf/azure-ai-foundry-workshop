// storage_cmk.tf

resource "null_resource" "wait_for_propagation" {
  triggers = {
    wait = module.core_kv.ra_propagation_delay
  }
}

module "core_storage_cmkey" {
  # tflint-ignore: terraform_module_pinned_source
  source = "git::https://github.com/shigeyf/terraform-azurerm-reusables.git//infra/terraform/modules/keyvault_key?ref=main"

  key_name    = var.storage_cmkey_name
  keyvault_id = module.core_kv.output.keyvault_id
  key_policy  = var.storage_cmkey_policy

  depends_on = [
    null_resource.wait_for_propagation,
  ]
}
