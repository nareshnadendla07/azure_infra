output "immutability_policy_ids" {
  description = "The resource IDs of the deployed immutability policies."
  value       = { for k, v in azurerm_storage_container_immutability_policy.this : k => v.id }
}
