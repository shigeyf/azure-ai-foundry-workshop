// global/main.tf

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.4.0"
  suffix  = [var.project, var.environment, var.location]
}

module "regions" {
  source  = "Azure/regions/azurerm"
  version = ">= 0.3.0"
}
