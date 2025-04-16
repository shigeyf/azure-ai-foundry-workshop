// ai_hub_cmk.tf

module "core_ai_hub_cmkey" {
  count = var.enable_ai_foundry_hub_encryption ? 1 : 0
  # tflint-ignore: terraform_module_pinned_source
  source = "git::https://github.com/shigeyf/terraform-azurerm-reusables.git//infra/terraform/modules/keyvault_key?ref=main"

  key_name    = var.ai_foundry_hub_cmkey_name
  keyvault_id = module.core_kv.output.keyvault_id
  key_policy  = var.ai_foundry_hub_cmkey_policy

  depends_on = [
    null_resource.wait_for_propagation,
    null_resource.unlock_kv_start,
  ]
}
