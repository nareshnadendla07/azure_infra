output "route_table_id" {
  value       = azurerm_route_table.this.id
  description = "The ID of the route table"
}

output "route_table_name" {
  value       = azurerm_route_table.this.name
}

output "route_ids" {
  value = [
    for r in azurerm_route.this : r.id
  ]
}

output "association_ids" {
  value = [
    for assoc in azurerm_subnet_route_table_association.this : assoc.id
  ]
}
