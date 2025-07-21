output "container_ids" {
  value = { for key, container in azurerm_storage_container.this : key => container.id }
}