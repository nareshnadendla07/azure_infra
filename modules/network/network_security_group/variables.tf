variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "The location where the resource will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Map a subnet ID to associate with the NSG"
  type        = string
  default = null
}

variable "rules" {
  description = "A list of security rules"
  type = list(object({
    name                       = string
    protocol                   = string
    source_port_range          = string
    destination_port_range    = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
    priority                   = number
    direction                  = string
  }))
}

variable "log_analytics_workspace_id" {
  description = "The name of log analytics workspace resource id"
  default     = null
}

variable "storage_account_id" {
  description = "The name of the hub storage account to store logs"
  default     = null
}

variable "nsg_diag_logs" {
  description = "NSG Monitoring Category details for Azure Diagnostic setting"
  default     = ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"]
}