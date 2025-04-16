// null_unlock_kv.tf

locals {
  keyvault_name = element(reverse(split("/", module.core_kv.output.keyvault_id)), 0)
}

resource "null_resource" "wait_for_propagation" {
  triggers = {
    wait = module.core_kv.ra_propagation_delay
  }
}

# Temporary unlock Key Vault for Key creation (always run)
resource "null_resource" "unlock_kv_start" {
  count = (!var.enable_public_network_access && var.enable_remote_deployment) ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
      az keyvault update -n ${local.keyvault_name} -g ${var.resource_group_name} --public-network-access Enabled
    EOT
  }
  depends_on = [
    null_resource.wait_for_propagation,
  ]
}

# Relock Key Vault (always run)
resource "null_resource" "unlock_kv_end" {
  count = (!var.enable_public_network_access && var.enable_remote_deployment) ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
      az keyvault update -n ${local.keyvault_name} -g ${var.resource_group_name} --public-network-access Disabled
    EOT
  }
  depends_on = [
    module.core_storage_cmkey,
    module.core_ai_hub_cmkey,
  ]
}
