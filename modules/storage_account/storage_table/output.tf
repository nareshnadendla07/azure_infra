output "table_names" {
  value       = [for table in azurerm_storage_table.this : table.name]
  description = "The names of the storage tables created."
}

output "table_ids" {
  value       = { for table in azurerm_storage_table.this : table.name => table.id }
  description = "The resource IDs of the storage tables created."
}
