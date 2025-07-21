variable "workspace_name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}

variable "location" {
  description = "The Azure Region where the workspace will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the workspace will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Log Analytics Workspace."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The retention period for logs in days."
  type        = number
  default     = 30
}

variable "tags" {
  description = "A map of tags to assign to the workspace."
  type        = map(string)
  default     = {}
}