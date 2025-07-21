variable "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  type        = string
}

variable "principal_id" {
  description = "The object ID of the principal (user, app, or managed identity)."
  type        = string
}

variable "secret_permissions" {
  description = "List of secret permissions."
  type        = list(string)
  default     = []
}

variable "key_permissions" {
  description = "List of key permissions."
  type        = list(string)
  default     = []
}

variable "certificate_permissions" {
  description = "List of certificate permissions."
  type        = list(string)
  default     = []
}
