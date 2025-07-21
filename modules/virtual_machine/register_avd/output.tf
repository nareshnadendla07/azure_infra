# outputs.tf
output "vm_extension_ids" {
  description = "The IDs of the virtual machine extensions used for session host registration"
  value       = azurerm_virtual_machine_extension.register_avd.*.id
}
