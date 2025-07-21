output "linux_vm_id" {
  value = azurerm_linux_virtual_machine.linux_vm[0].id
}

output "linux_vm_name" {
  value = azurerm_linux_virtual_machine.linux_vm[0].name
}

output "linux_vm_location" {
  value = azurerm_linux_virtual_machine.linux_vm[0].location
}

output "linux_vm_resource_group_name" {
  value = azurerm_linux_virtual_machine.linux_vm[0].resource_group_name
}

output "linux_vm_size" {
  value = azurerm_linux_virtual_machine.linux_vm[0].size
}
