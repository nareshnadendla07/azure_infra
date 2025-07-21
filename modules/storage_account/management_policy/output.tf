output "management_policy_id" {
  value = azurerm_storage_management_policy.this.id
  description = "The ID of the storage management policy applied."
}
