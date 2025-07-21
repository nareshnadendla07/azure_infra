# role_assignment/outputs.tf
output "role_assignment_id" {
  value = azurerm_role_assignment.example.id
}
