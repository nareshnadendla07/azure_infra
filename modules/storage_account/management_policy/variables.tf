variable "storage_account_id" {
  description = "The resource ID of the storage account to which the management policy will be applied."
  type        = string
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
    default = []
}