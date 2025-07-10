output "route_table_id" {
  description = "The ID of the created Azure Route Table."
  value       = module.avd_routeTables.route_table_id
}

output "route_table_name" {
  description = "The name of the created Azure Route Table."
  value       = module.avd_routeTables.route_table_name
}

output "route_ids" {
  description = "List of IDs of routes added to the route table."
  value       = module.avd_routeTables.route_ids
}

output "route_association_ids" {
  description = "List of subnet-route table association resource IDs."
  value       = module.avd_routeTables.association_ids
}
