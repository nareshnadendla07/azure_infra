variable "location" {
  description = "Location for all resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  description = "Tags of the resource."
  type        = map(string)
}

variable "storage_account_name" {
  description = "The name of the parent Storage Account. Required if the template is used in a standalone deployment."
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account."
  type        = string
}

variable "account_replication_type" {
  description = "The type of replication to use for the storage account."
  type        = string
}

variable "account_kind" {
  description = "The type of kind to use for the storage account."
  type        = string
}

variable "public_network_access_enabled" {
  description = "The public network access enabled to use for the storage account."
  type        = string
}


variable "is_hns_enabled" {
  description = "Specifies whether the hierarchical namespace is enabled for the storage account."
  type        = bool
}

variable "default_access_tier" {
  description = "The default access tier for the storage account."
  type        = string
  
}

variable "change_feed_enabled" {
  description = "Enable/disable change feed."
  type        = bool
}

variable "change_feed_retention_in_days" {
  description = "Indicates the duration of change feed retention in days."
  type        = number
}

variable "create_access_policy" {
  description = "Whether to create the Key Vault access policy."
  type        = bool
  
}

variable "shared_access_key_enabled" {
  description = "Determines if Shared Access Signatures (SAS) are enabled for this storage account. Set to true to enable SAS, allowing fine-grained, ephemeral access control to various aspects of the storage account. Set to false to disable."
  type        = bool
}

variable "container_delete_retention_policy_in_days" {
  description = "Number of days to retain deleted containers."
  type        = number
}

variable "enable_advanced_threat_protection" {
  description = "Boolean flag which controls if advanced threat protection is enabled."  
  type        = bool
}


variable "cors_rules" {
  description = "CORS rules for the storage account."
  type = list(object({
    allowed_origins    = list(string)
    allowed_methods    = list(string)
    allowed_headers    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
}

variable "default_service_version" {
  description = "Default service version for the storage account."
  type        = string
}

variable "blob_soft_delete_retention_days" {
  description = "Number of days to retain deleted blobs."
  type        = number
}

variable "blob_permanent_delete_enabled" {
  description = "Specifies whether permanent delete is enabled for blobs."
  type        = bool
}


variable "is_versioning_enabled" {
  description = "Enable/disable versioning."
  type        = bool
}

variable "last_access_time_tracking_policy_enabled" {
  description = "Enable/disable last access time tracking policy."
  type        = bool
}


variable "network_rules" {
  description = "Network rules restricing access to the storage account."
  type        = object({ bypass = list(string), ip_rules = list(string), subnet_ids = list(string) })
  default     = null
}

variable "queue_retention_policy_days" {
  description = "Number of days to retain logs for queue."
  type        = number
}

variable "containers" {
  description = "A map of containers with their properties."
  type = map(object({
    name                     = string
    container_access_type    = string
    default_encryption_scope = string
    metadata                 = map(string)
    immutability_policy_properties = object({
      immutability_period_since_creation_in_days = number
      allow_protected_append_writes              = bool
      allow_protected_append_writes_all          = bool
    })
  }))
}

variable "tables" {
  description = "List of tables to create"
  type        = list(object({
    name     = string
    metadata = map(string)
  }))
  default     = []
}

variable "queues" {
  description = "List of queues to create"
  type        = list(object({
    name     = string
    metadata = map(string)
  }))
  default     = []
}

variable "file_shares" {
  description = "List of file shares to create"
  type        = list(object({
    name             = string
    quota            = number
    access_tier      = string
    enabled_protocol = string
    metadata         = map(string)
  }))
  default     = []
}


variable "management_policies" {
  description = "List of management policy rules to apply to the storage account."
  type = list(object({
    name    = string
    enabled = bool
    filters = optional(object({
      prefix_match = optional(list(string), [])
      blob_types   = optional(list(string), ["blockBlob"])
      tag = optional(object({
        name      = string
        operation = string
        value     = string
      }), null)
    }), null)
    actions = object({
      base_blob = optional(object({
        tier_to_cool_after_days_since_modification_greater_than    = optional(number, null)
        tier_to_archive_after_days_since_modification_greater_than = optional(number, null)
        delete_after_days_since_modification_greater_than          = optional(number, null)
      }), {})
      snapshot = optional(object({
        delete_after_days_since_creation_greater_than = optional(number, null)
      }), {})
      version = optional(object({
        change_tier_to_archive_after_days_since_creation = optional(number, null)
        change_tier_to_cool_after_days_since_creation    = optional(number, null)
        delete_after_days_since_creation                 = optional(number, null)
      }), {})
    })
  }))

  # Fixed: Prevent Terraform from accessing `.tag.operation` when `filters` is null
  # # validation {
  #   condition = alltrue([
  #     for policy in var.management_policies :
  #     policy.filters != null && policy.filters.tag != null ? contains(["=="], policy.filters.tag.operation) : true
  #   ])
  #   error_message = "The operation in management_policies.filters.tag must be '==' if tag is used."
  # }
}

variable "include_containers" {
  description = "Set to true to include storage containers"
  type        = bool
  default     = false
}

variable "include_file_shares" {
  description = "Set to true to include file shares"
  type        = bool
  default     = false
}

variable "include_tables" {
  description = "Set to true to include tables"
  type        = bool
  default     = false
}

variable "include_queues" {
  description = "Set to true to include queues"
  type        = bool
  default     = false
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

variable "key_vault_id" {
  description = "The URL to a Key Vault Key"
  type = string
}

variable "key_vault_key_name" {
  description = "The URL to a Key Vault Key"
  type = string
}

variable "storage_encryption_tenant_id" {
  description = "The "
  type = string
  
}

variable "storage_encryption_principal_id" {
  description = "The "
  type = string
  
}

variable "identity_id" {
  description = "List of User Assigned Managed Identity IDs."
  type        = string
  
}

variable "identity_principal_id" {
  description = "List of User Assigned Managed Identity IDs."
  type        = string
  
}

variable "include_blobs" {
  description = "Boolean flag to include blob creation"
  type        = bool
  default     = false
}

variable "blob_name" {
  description = "The name of the blob"
  type        = string
}

variable "blob_source" {
  description = "The path to the source file for the blob (local or remote)"
  type        = string
}

variable "blob_type" {
  description = "The type of the blob. Valid options are Block, Append, or Page"
  type        = string
  default     = "Block"
}

variable "storage_container_name" {
  description = "The name of the storage container where the blob will be created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}


variable "delete_retention_policy_days" {
  description = "Number of days to retain deleted blobs."
  type        = number
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}