output "asg_id" {
  description = "The ID of the Application Security Group"
  value       = azurerm_application_security_group.asg.id
}


output "asg_name" {
  value = azurerm_application_security_group.asg.name
}

output "network_interface_asg_association_id" {
  value = azurerm_network_interface_application_security_group_association.example.id
}
