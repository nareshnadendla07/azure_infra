variable "cognitive_name" {
  description = "Name of the Document Intelligence account"
  type        = string
}

variable "location" {
  description = "Azure location for the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU for the Cognitive Service (F0 or S0)"
  type        = string
  default     = ""
}

variable "kind" {
  description = "Specifies the type of Azure Cognitive Service account. For Document Intelligence, use 'DocumentIntelligence'. Other examples include 'CognitiveServices', 'TextAnalytics', 'Face', etc."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Specifies whether public network access is allowed for the Cognitive Services account. Set to 'true' to allow access from the public internet, or 'false' to restrict access to private endpoints only."
  type        = bool
}

variable "custom_subdomain_name" {
  description = "The custom subdomain name to use for the Cognitive Services endpoint. This becomes part of the FQDN used to access the service (e.g., https://<custom_subdomain_name>.cognitiveservices.azure.com)."
  type        = string
}

variable "default_action" {
  description = "The default action to use for the Cognitive Services endpoint."
  type        = string
}


variable "tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to which diagnostic logs will be sent."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account to which diagnostic logs will be sent."
  type        = string
}
