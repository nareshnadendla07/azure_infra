output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = { for subnet in azurerm_virtual_network.vnet.subnet : subnet.name => subnet.id }
}

output "subnet_name_id_map" {
  value = { for name, details in module.subnet.subnets : name => details.id }
  description = "Map of subnet names to their IDs."
}

output "resource_group_name" {
  value = azurerm_resource_group.rg[0].name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg[0].id
}

output "location" {
  value = azurerm_resource_group.rg[0].location
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "address_prefixes" {
  value = azurerm_virtual_network.vnet.address_space
}