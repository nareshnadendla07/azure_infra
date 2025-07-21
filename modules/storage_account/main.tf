data "azurerm_client_config" "current" {}

locals {
  final_sa_name = var.storage_account_name == null ? "stsqlauditlogs" : substr(var.storage_account_name, 0, 24)
}

##############################
# Azure Storage Account Module
##############################

resource "azurerm_storage_account" "this" {
  name                          = local.final_sa_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = var.account_kind
  public_network_access_enabled = var.public_network_access_enabled


  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids

  }

  dynamic "blob_properties" {
    for_each = (var.account_kind == "BlockBlobStorage" || var.account_kind == "StorageV2") ? [1] : []
    content {
      change_feed_enabled           = var.change_feed_enabled
      change_feed_retention_in_days = var.change_feed_retention_in_days

      dynamic "container_delete_retention_policy" {
        for_each = (var.container_delete_retention_policy_in_days == 0 ? [] : [1])
        content {
          days = var.container_delete_retention_policy_in_days
        }
      }

      dynamic "cors_rule" {
        for_each = var.cors_rules == null ? [] : var.cors_rules
        content {
          allowed_origins    = cors_rule.value.allowed_origins
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_headers    = cors_rule.value.allowed_headers
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      default_service_version = var.default_service_version

      dynamic "delete_retention_policy" {
        for_each = (var.delete_retention_policy_days == 0 ? [] : [1])
        content {
          days = var.delete_retention_policy_days
        }
      }

      versioning_enabled = var.is_versioning_enabled

      last_access_time_enabled = var.last_access_time_tracking_policy_enabled

    }

  }

  tags = merge({ "Name" = format("%s", var.storage_account_name) }, var.tags, )

  lifecycle {
    prevent_destroy = false
  }
}

############################################
# Azure Storage Account Customer Managed Key
############################################

resource "azurerm_storage_account_customer_managed_key" "this" {
  storage_account_id        = azurerm_storage_account.this.id
  key_name                  = var.key_vault_key_name
  key_vault_id              = var.key_vault_id
  user_assigned_identity_id = var.identity_id

  lifecycle {
    ignore_changes = [
      key_vault_key_version, # Ignore changes to key version to avoid unnecessary updates
    ]
  }

}

##########################
# Storage Container Module
##########################

module "storage_containers" {
  count               = var.include_containers ? 1 : 0
  depends_on          = [azurerm_storage_account.this]
  source              = "./storage_container"
  storage_account_id  = azurerm_storage_account.this.id
  containers          = var.containers
  resource_group_name = var.resource_group_name
}

#####################
# Storage Blob Module
#####################

module "storage_blob" {
  count = var.include_blobs ? 1 : 0

  source                 = "./storage_blob"
  blob_name              = var.blob_name
  blob_source            = var.blob_source
  blob_type              = var.blob_type
  storage_container_name = module.storage_containers[0].storage_container_name
  storage_account_name   = azurerm_storage_account.this.name
  depends_on             = [azurerm_storage_account.this]
}

###########################
# Storage File Share Module
###########################

module "file_share" {
  count              = var.include_file_shares ? 1 : 0
  depends_on         = [azurerm_storage_account.this]
  source             = "./file_share"
  storage_account_id = azurerm_storage_account.this.id
  file_shares        = var.file_shares
}

######################
# Storage Table Module
######################

module "table" {
  count                = var.include_tables ? 1 : 0
  depends_on           = [azurerm_storage_account.this]
  source               = "./storage_table"
  storage_account_name = azurerm_storage_account.this.name
  tables               = var.tables
}

######################
# Storage Queue Module
######################

module "queue" {
  count                = var.include_queues ? 1 : 0
  depends_on           = [azurerm_storage_account.this]
  source               = "./storage_queue"
  storage_account_name = azurerm_storage_account.this.name
  queues               = var.queues
}

##################################
# Storage Management Policy Module
##################################

module "management_policy" {
  count      = (var.account_kind == "StorageV2" || var.account_kind == "BlockBlobStorage") ? 1 : 0
  depends_on = [azurerm_storage_account.this]

  source              = "./management_policy"
  storage_account_id  = azurerm_storage_account.this.id
  management_policies = var.management_policies
}

#####################
## Diagnostic Setting
#####################

resource "azurerm_monitor_diagnostic_setting" "sa_diagnostics" {
  name                       = "${var.storage_account_name}-diag"
  target_resource_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  #storage_account_id = var.storage_account_id

  enabled_log {
    category = "StorageDelete"
  }

  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }

  enabled_metric {
    category = "AllMetrics"

  }
}
