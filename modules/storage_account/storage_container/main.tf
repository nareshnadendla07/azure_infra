################################
# Azure Storage Container Module
#################################

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                     = each.key
  #storage_account_name     = var.storage_account_name
  storage_account_id = var.storage_account_id
  container_access_type    = each.value.container_access_type
  default_encryption_scope = each.value.default_encryption_scope
  metadata                 = each.value.metadata
}

####################################################
# Azure Storage Container Immutability Policy Module
####################################################
module "immutability_policy" {
  for_each = var.containers
  source   = "./immutability-policy"

  containers = var.containers
  storage_container_resource_manager_id = try(azurerm_storage_container.this[each.key].resource_manager_id, "")
  depends_on = [azurerm_storage_container.this]
}