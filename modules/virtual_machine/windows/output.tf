output "vm_id" {
  value = length(azurerm_windows_virtual_machine.win_vm) > 0 ? [for vm in azurerm_windows_virtual_machine.win_vm : vm.id] : []
}