##################
## storage account
##################

variable "storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "arc_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "evd_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "cases_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "matter_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "legal_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "admin_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "nuix_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "tmp_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "account_tier" {
  description = "The tier for the storage account."
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


variable "container_delete_retention_policy_in_days" {
  description = "Number of days to retain deleted blobs in containers."
  type        = number
}

variable "blob_soft_delete_retention_days" {
  description = "The number of days to retain deleted blobs for the entire storage account."
  type        = number
}

variable "is_versioning_enabled" {
  description = "Global setting to enable versioning across blob storage."
  type        = bool
}

variable "change_feed_enabled" {
  description = "Enables the change feed feature for blob storage."
  type        = bool
}

variable "change_feed_retention_in_days" {
  description = "Indicates the duration of change feed retention in days."
  type        = number
}

variable "last_access_time_tracking_policy_enabled" {
  description = "Indicates whether last access time tracking is enabled for blobs in the storage account."
  type        = bool
}

variable "queue_retention_policy_days" {
  description = "The number of days to retain messages in queues."
  type        = number
}

variable "default_service_version" {
  description = "The default service version for requests to the storage account."
  type        = string
}

variable "mssql_private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}

variable "sa_private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}

variable "evd_private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}

variable "delete_retention_policy_days" {
  description = "The number of days to retain deleted blobs for the entire storage account."
  type        = number
}

############################
## Managed Identity varibles
############################

variable "managed_identity_name" {
  description = "The name of the Managed Identity"
  type        = string
}