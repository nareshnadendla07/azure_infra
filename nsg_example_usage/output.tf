output "nsg_id" {
  description = "The ID of the created Network Security Group."
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "The name of the Network Security Group."
  value       = azurerm_network_security_group.nsg.name
}

output "nsg_resource_group" {
  description = "The resource group where the NSG is created."
  value       = azurerm_network_security_group.nsg.resource_group_name
}

output "nsg_rules" {
  description = "List of security rule names applied to the NSG."
  value       = [for rule in azurerm_network_security_group.nsg.security_rule : rule.name]
}

output "nsg_association_id" {
  description = "The ID of the NSG association with the subnet."
  value       = azurerm_subnet_network_security_group_association.nsg-assoc.id
}
