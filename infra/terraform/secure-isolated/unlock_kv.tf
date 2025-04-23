// unlock_kv.tf

# This file is used for remote deployment to unlock the Key Vault access from Internet
# If you are using this deployment IaC on the private virtual network, you can ignore this file and resources.

# Temporary unlock Key Vault for Key creation
resource "null_resource" "main_temporary_unlock_kv" {
  count = (!var.enable_public_network_access && var.enable_remote_deployment) ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
      az keyvault update -n ${local.keyvault_name} -g ${local.resource_group_name} --public-network-access Enabled
    EOT
  }
  depends_on = [
    module.ai_foundry_hub,
  ]
}

# Relock Key Vault
resource "null_resource" "main_re_lock_kv" {
  count = (!var.enable_public_network_access && var.enable_remote_deployment) ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOT
      az keyvault update -n ${local.keyvault_name} -g ${local.resource_group_name} --public-network-access Disabled
    EOT
  }
  depends_on = [
    module.ai_foundry_services,
    module.ai_foundry_project,
  ]
}
