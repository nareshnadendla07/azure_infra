output "managed_disk_id" {
  description = "The ID of the managed disk."
  value       = azurerm_managed_disk.this.id
}

output "managed_disk_name" {
  description = "The name of the managed disk."
  value       = azurerm_managed_disk.this.name
}

output "managed_disk_size" {
  description = "The size of the managed disk in GB."
  value       = azurerm_managed_disk.this.disk_size_gb
}

output "data_disk_attachment_id" {
  description = "The ID of the data disk attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.id
}

output "data_disk_attachment_lun" {
  description = "The Logical Unit Number (LUN) of the data disk attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.lun
}

output "data_disk_attachment_caching" {
  description = "The caching mode of the data disk attachment."
  value       = azurerm_virtual_machine_data_disk_attachment.this.caching
}
