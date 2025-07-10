###########################
# Output the route table ID
###########################

output "route_table_id" {
  description = "The ID of the Route Table"
  value       = azurerm_route_table.this.id
}

########################
# Output the route names
########################

output "routes" {
  description = "The routes in the Route Table"
  value       = [for r in azurerm_route.this : r.name]
}
