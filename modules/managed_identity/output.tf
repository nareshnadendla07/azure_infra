// modules/managed_identity/outputs.tf
output "identity_id" {
  description = "The ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.example.id
}

output "principal_id" {
  description = "The Principal ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.example.principal_id
}

output "client_id" {
  description = "The Client ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.example.client_id
}
