####################################################
# Azure Storage Container Immutability Policy Module
#####################################################

resource "azurerm_storage_container_immutability_policy" "this" {
  for_each = var.containers

  storage_container_resource_manager_id = var.storage_container_resource_manager_id
  immutability_period_in_days           = each.value.immutability_policy_properties.immutability_period_since_creation_in_days
  protected_append_writes_all_enabled   = each.value.immutability_policy_properties.allow_protected_append_writes_all
  protected_append_writes_enabled       = each.value.immutability_policy_properties.allow_protected_append_writes
}