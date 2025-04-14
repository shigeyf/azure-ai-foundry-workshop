// _outputs.tf

output "output" {
  value = {
    ai_services_id = azurerm_ai_services.this.id
  }
  description = "AI service resources for AI Foundry"
}
