output "private_endpoint_id" {
  description = "The ID of the created private endpoint."
  value       = azurerm_private_endpoint.this.id
}