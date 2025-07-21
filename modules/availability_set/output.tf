output "availability_set_id" {
  value       = azurerm_availability_set.this.id
  description = "The ID of the Availability Set"
}
output "availability_set_name" {
  value       = azurerm_availability_set.this.name
  description = "The name of the Availability Set"
}