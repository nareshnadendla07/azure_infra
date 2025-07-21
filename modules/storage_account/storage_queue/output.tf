output "queue_names" {
  value       = [for queue in azurerm_storage_queue.this : queue.name]
  description = "The names of the storage queues created."
}

output "queue_ids" {
  value       = { for queue in azurerm_storage_queue.this : queue.name => queue.id }
  description = "The resource IDs of the storage queues created."
}
