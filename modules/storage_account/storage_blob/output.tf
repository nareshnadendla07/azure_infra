output "blob_url" {
  description = "The URL of the created storage blob."
  value       = azurerm_storage_blob.blob.url
}

output "blob_name" {
  description = "The name of the created storage blob."
  value       = azurerm_storage_blob.blob.name
}
