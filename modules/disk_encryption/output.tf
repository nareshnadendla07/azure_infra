output "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set"
  value       = azurerm_disk_encryption_set.vm_disk_encryption.id
}

output "disk_encryption_set_name" {
  description = "The name of the Disk Encryption Set"
  value       = azurerm_disk_encryption_set.vm_disk_encryption.name
}

output "disk_encryption_principal_id" {
  value = lookup(azurerm_disk_encryption_set.vm_disk_encryption.identity[0], "principal_id", null)
}
