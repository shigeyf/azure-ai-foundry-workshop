// _outputs.tf

output "output" {
  value = {
    ai_foundry_private_dns_zones = module.ai_foundry_dns_zones.private_dns_zone_ids
    ai_foundry_vnet              = module.ai_foundry_vnet.output
    ai_foundry_core              = module.ai_foundry_hub.output
    ai_foundry_services          = module.ai_foundry_services.output
    ai_foundry_project           = module.ai_foundry_project.output
  }
}
