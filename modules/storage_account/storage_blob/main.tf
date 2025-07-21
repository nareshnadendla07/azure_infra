###########################
# Azure Storage Blob Module
###########################

resource "azurerm_storage_blob" "blob" {
  name                   = var.blob_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = var.blob_type
  source                 = var.blob_source
}

#############################################
# Azure Storage Account Blob Inventory Policy
#############################################

resource "azurerm_storage_account_blob_inventory_policy" "this" {
  storage_account_id = azurerm_storage_account.this.id
  name               = "${var.storage_account_name}-inventory"
  enabled            = var.inventory_enabled

  dynamic "rule" {
    for_each = var.inventory_rules == null ? [] : var.inventory_rules
    content {
      name     = rule.value.name
      filters {
        blob_types = rule.value.blob_types
      }
      format {
        type = rule.value.format_type
      }
      schedule {
        frequency = rule.value.frequency
      }
    }
  }
}