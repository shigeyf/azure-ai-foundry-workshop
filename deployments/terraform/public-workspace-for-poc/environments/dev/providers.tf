// envs/dev/providers.tf

# tflint-ignore: terraform_required_providers
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  storage_use_azuread = true
}
