output "file_share_ids" {
  value = { for share in azurerm_storage_share.this : share.name => share.id }
  description = "The resource IDs of the file shares created."
}

output "file_share_urls" {
  value = { for share in azurerm_storage_share.this : share.name => share.url }
  description = "The URLs of the file shares created."
}
