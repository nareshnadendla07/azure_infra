# Output the names of the extensions created
output "vm_extension_names" {
  description = "Names of the VM extensions"
  value       = [for ext in azurerm_virtual_machine_extension.this : ext.name]
}

# Output the virtual machine IDs for which the extension was applied
output "vm_extension_vm_ids" {
  description = "VM IDs for which the extension was applied"
  value       = [for ext in azurerm_virtual_machine_extension.this : ext.virtual_machine_id]
}

# Output the status of the extension, if available
output "vm_extension_status" {
  description = "The status of the VM extensions"
  value       = [for ext in azurerm_virtual_machine_extension.this : ext.id]  # Can be modified to extract status if available
}

# Output the fully qualified IDs of the extensions (Azure Resource Manager IDs)
output "vm_extension_resource_ids" {
  description = "Resource IDs of the VM extensions"
  value       = [for ext in azurerm_virtual_machine_extension.this : ext.id]
}
