########################################
# Azure Storage Management Policy Module
########################################

resource "azurerm_storage_management_policy" "this" {
  storage_account_id = var.storage_account_id

  dynamic "rule" {
    for_each = var.management_policies

    content {
      name    = rule.value.name
      enabled = rule.value.enabled
      
      dynamic "filters" {
        for_each = rule.value.filters != null ? [rule.value.filters] : [{
          prefix_match = []
          blob_types   = ["blockBlob"]
          tag = null
        }]
        content {
          prefix_match = lookup(filters.value, "prefix_match", [])
          blob_types   = lookup(filters.value, "blob_types", ["blockBlob"])
          
        }
      }

      actions {
        base_blob {
          tier_to_cool_after_days_since_modification_greater_than    = lookup(rule.value.actions.base_blob, "tier_to_cool_after_days_since_modification_greater_than", null)
          tier_to_archive_after_days_since_modification_greater_than = lookup(rule.value.actions.base_blob, "tier_to_archive_after_days_since_modification_greater_than", null)
          tier_to_cold_after_days_since_modification_greater_than = lookup(rule.value.actions.base_blob, "tier_to_cold_after_days_since_modification_greater_than", null)
          delete_after_days_since_modification_greater_than          = lookup(rule.value.actions.base_blob, "delete_after_days_since_modification_greater_than", null)
        }

        snapshot {
          delete_after_days_since_creation_greater_than = lookup(rule.value.actions.snapshot, "delete_after_days_since_creation_greater_than", null)
        }

        version {
          change_tier_to_archive_after_days_since_creation = lookup(rule.value.actions.version, "change_tier_to_archive_after_days_since_creation", null)
          change_tier_to_cool_after_days_since_creation    = lookup(rule.value.actions.version, "change_tier_to_cool_after_days_since_creation", null)
          delete_after_days_since_creation                 = lookup(rule.value.actions.version, "delete_after_days_since_creation", null)
        }
      }
    }
  }
}
