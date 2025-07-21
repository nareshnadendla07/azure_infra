output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.this.name
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the Storage Account"
  value       = azurerm_storage_account.this.primary_access_key
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint for the Storage Account"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "storage_account_primary_queue_endpoint" {
  description = "The primary queue endpoint for the Storage Account"
  value       = azurerm_storage_account.this.primary_queue_endpoint
}

output "storage_account_primary_table_endpoint" {
  description = "The primary table endpoint for the Storage Account"
  value       = azurerm_storage_account.this.primary_table_endpoint
}

output "storage_account_primary_file_endpoint" {
  description = "The primary file endpoint for the Storage Account"
  value       = azurerm_storage_account.this.primary_file_endpoint
}

output "mssql_logs_container_path" {
  value = length(module.storage_containers) > 0 ? join("", [
    for container in module.storage_containers : (
      contains(keys(container.container_ids), "mssql-logs") ? "${azurerm_storage_account.this.primary_blob_endpoint}${container.container_ids["mssql-logs"]}/" : ""
    )
  ]) : ""
}

output "storage_account_principal_id" {
  description = "The principal ID of the user-assigned managed identity for the storage account."
  value       = azurerm_storage_account.this.identity[0].principal_id # Accessing the principal ID of the first user-assigned identity.
}

# output "mssql_logs_container_path" {
#   value = length(module.storage_containers) > 0 && contains(keys(module.storage_containers[0].container_ids), "mssql-logs") ? "${azurerm_storage_account.this.primary_blob_endpoint}${module.storage_containers[0].container_ids["mssql-logs"]}/" : ""
# }


