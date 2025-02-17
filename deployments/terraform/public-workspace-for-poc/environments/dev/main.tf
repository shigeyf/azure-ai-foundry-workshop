// envs/dev/main.tf

module "global" {
  source      = "../../global/"
  project     = var.project
  environment = var.environment
  location    = var.location
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

module "azure_ai_foundry_resources" {
  source               = "../../modules/azure_ai_foundry/"
  resource_group_name  = local.resource_group_name
  storage_account_name = local.storage_account_name
  key_vault_name       = local.key_vault_name
  location             = var.location
  unique_suffix        = random_string.random.result
  unique_suffix_length = random_string.random.length
  tags                 = var.tags
}
