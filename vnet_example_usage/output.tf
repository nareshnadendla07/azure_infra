output "vnet_id" {
  value       = module.vnet.virtual_network_id
  description = "The ID of the virtual network."
}

output "subnet_ids" {
  value       = module.vnet.subnet_name_id_map
  description = "A map of subnet names to subnet IDs."
}
