variable "vm_name" {
  description = "Name of the virtual machine associated with the disk encryption set"
  type        = string
}

variable "location" {
  description = "Azure location where the disk encryption set will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the disk encryption set will be created"
  type        = string
}

variable "disk_encryption_set_name" {
  description = "ID of the Key Vault that contains the key for encryption"
  type        = string
}

variable "key_vault_key_id" {
  description = "ID of the key in the Key Vault used for disk encryption"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the disk encryption key is stored"
  type        = string
}

variable "auto_key_rotation_enabled" {
    description = "value of auto_key_rotation_enabled"
    type = bool
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

variable "disk_encryption_principal_id" {
  description = "The User Assigned Managed Identity IDs."
  type = string
}



variable "tags" {
  description = "Tags to apply to the disk encryption set"
  type        = map(string)
  default     = {}
}
