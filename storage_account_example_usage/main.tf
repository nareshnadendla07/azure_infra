######################################
## Create Storage Account for Archive
######################################

module "arc_storage_account" {
  source = "../../modules/storage-account"

  storage_account_name              = var.arc_storage_account_name
  resource_group_name               = data.azurerm_resource_group.rg.name
  location                          = var.location
  account_tier                      = var.account_tier
  account_kind                      = var.account_kind
  public_network_access_enabled     = var.public_network_access_enabled
  tags                              = var.tags
  account_replication_type          = "LRS"
  include_containers                = false
  include_file_shares               = false
  include_tables                    = false
  include_queues                    = false
  key_vault_id                      = data.azurerm_key_vault.example.id
  key_vault_key_name                = data.azurerm_key_vault_key.example.name
  storage_encryption_principal_id   = data.azurerm_user_assigned_identity.example.principal_id
  storage_encryption_tenant_id      = data.azurerm_client_config.current.tenant_id
  identity_ids                      = [data.azurerm_user_assigned_identity.example.id]
  identity_id                       = data.azurerm_user_assigned_identity.example.id
  enable_advanced_threat_protection = false
  shared_access_key_enabled         = true
  delete_retention_policy_days      = var.delete_retention_policy_days
  log_analytics_workspace_id        = var.log_analytics_workspace_id
  create_access_policy              = false

  cors_rules = [
    {
      allowed_origins    = ["*"],
      allowed_methods    = ["GET", "POST"],
      allowed_headers    = ["*"],
      exposed_headers    = ["*"],
      max_age_in_seconds = 3600
    }
  ]


  containers = {
    "matter-12345-test" = {
      name                     = "matter-12345-test"
      container_access_type    = "private"
      default_encryption_scope = "default"
      metadata                 = { "owner" = "admin" }
      immutability_policy_properties = {
        immutability_period_since_creation_in_days = 365
        allow_protected_append_writes              = true
        allow_protected_append_writes_all          = false
      }
    }
  }

  file_shares = []

  tables = []


  container_delete_retention_policy_in_days = "60" #var.container_delete_retention_policy_in_days
  blob_soft_delete_retention_days           = "60" #var.blob_soft_delete_retention_days
  blob_permanent_delete_enabled             = false
  is_versioning_enabled                     = var.is_versioning_enabled
  change_feed_enabled                       = var.account_replication_type == "ZRS" ? false : var.change_feed_enabled
  change_feed_retention_in_days             = var.account_replication_type == "ZRS" ? null : var.change_feed_retention_in_days
  last_access_time_tracking_policy_enabled  = var.last_access_time_tracking_policy_enabled
  is_hns_enabled                            = true
  default_access_tier                       = "Hot"
  # restore_policy_days                       = var.restore_policy_days

  queue_retention_policy_days = var.queue_retention_policy_days
  management_policies = [
    {
      name    = "archival_lifecyclePolicy",
      enabled = true
      filters = {
        blob_types = ["blockBlob"] # Applies to all block blobs        
      },
      actions = {
        base_blob = {
          tier_to_cool_after_days_since_modification_greater_than    = 1,
          tier_to_archive_after_days_since_modification_greater_than = var.account_replication_type == "ZRS" ? null : 7
          #delete_after_days_since_modification_greater_than          = 365
        },
        snapshot = {
          delete_after_days_since_creation_greater_than = 7
        },
        version = {
          change_tier_to_archive_after_days_since_creation = var.account_replication_type == "ZRS" ? null : 7
          change_tier_to_cool_after_days_since_creation    = 1,
          delete_after_days_since_creation                 = 90
        }
      }
    }
  ]
  default_service_version = var.default_service_version


  ##depends_on = [module.managed_identity, module.storage_account]

}

#######################################################
## create storage account private endpoint for Evidence
#######################################################

module "arc_privateEndpoint" {
  source              = "../../modules/network/private-endpoint"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  private_endpoint_name = "${var.arc_storage_account_name}-pep"
  subnet_resource_id    = data.azurerm_subnet.default_snet.id
  private_link_service_connections = [
    {
      name                           = "${var.arc_storage_account_name}-pep-con"
      is_manual_connection           = false
      private_connection_resource_id = module.arc_storage_account.storage_account_id
      subresource_names              = ["blob"]
    }
  ]

  #custom_network_interface_name = "${var.evd_storage_account_name}-nic"  
  private_dns_zone_group_name   = "default"
  private_dns_zone_resource_ids = var.evd_private_dns_zone_resource_ids

  tags = var.tags

  depends_on = [module.arc_storage_account]
}
