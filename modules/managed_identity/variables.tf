// modules/managed_identity/variables.tf
variable "manaaged_identity_name" {
  description = "The name of the Managed Identity"
  type        = string
}

variable "location" {
  description = "The location where the Managed Identity will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Managed Identity"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}



variable "principal_id" {
  description = "The Principal ID of the Managed Identity"
  type        = string
  default     = null
}

variable "client_id" {
  description = "The Client ID of the Managed Identity"
  type        = string
  default     = null
}

