variable "disk_name" {
  description = "The name of the managed disk."
  type        = string
}

variable "location" {
  description = "The location of the managed disk."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name."
  type        = string
}

variable "storage_account_type" {
  description = "The storage account type."
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "The size of the managed disk in GB."
  type        = number
  default     = 128
}

variable "virtual_machine_id" {
  description = "The ID of the virtual machine."
  type        = string
}

variable "lun" {
  description = "The Logical Unit Number (LUN) for the data disk."
  type        = number
  default     = 0
}

variable "caching" {
  description = "The caching mode for the data disk."
  type        = string
  default     = "ReadWrite"
}

variable "disk_encryption_set_id" {
  description = "The resource ID of the disk encryption set to be used for encrypting the managed disk. This should be in the format of a resource ID string."
  type        = string
}

variable "disk_access_id" {
  description = "ID of the Disk Access resource to allow private access. Set to null to skip."
  type        = string
  default     = null
}

variable "create_option" {
  description = "ID of the Disk Access resource to allow private access. Set to null to skip."
  type        = string
  default     = null
}

variable "network_access_policy" {
  description = "ID of the Disk Access resource to allow private access. Set to null to skip."
  type        = string
  default     = null
}

variable "enable_private_access" {
  description = "If true, sets network_access_policy to AllowPrivate for private endpoint usage."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Controls whether public network access is enabled. Set to false to disable public access."
  type        = bool
  default     = null
}
