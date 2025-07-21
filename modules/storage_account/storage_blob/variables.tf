#############################
# Variables for Blob Module
#############################

variable "blob_name" {
  description = "The name of the blob."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container."
  type        = string
}

variable "blob_type" {
  description = "The type of the blob. Valid options are: Block, Page, or Append."
  type        = string
  default     = "Block"
}

variable "blob_source" {
  description = "The path to the source file to upload as a blob."
  type        = string
}

#########################################
# Variables for Blob Inventory Policy
#########################################

variable "inventory_enabled" {
  description = "Whether the inventory policy is enabled."
  type        = bool
  default     = true
}

variable "inventory_rules" {
  description = <<EOT
A list of inventory policy rules. Each rule object may contain:
- name: The rule name
- blob_types: List of blob types (e.g., ["blockBlob"])
- format_type: The format type (e.g., "Csv")
- frequency: The frequency (e.g., "Daily" or "Weekly")
EOT
  type = list(object({
    name        = string
    blob_types  = list(string)
    format_type = string
    frequency   = string
  }))
  default = []
}
variable "include_containers" {
  description = "Whether to include the storage containers module."
  type        = bool
  default     = true
}