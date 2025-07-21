variable "storage_account_id" {
  description = "The name of the storage account associated with the containers."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the storage account and containers are located."
  type        = string
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