// _outputs.tf

output "output" {
  value = {
    ai_foundry_core     = module.ai_foundry_hub.output
    ai_foundry_services = module.ai_foundry_services.output
    ai_foundry_project  = module.ai_foundry_project.output
  }
}
