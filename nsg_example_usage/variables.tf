variable "nsg_name" {
  description = "The name of the Network Secuirity Group."
  type        = string  
}

variable "location" {
  description = "Azure region to deploy resources into."
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "my-network-rg"
}


variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "infra-team"
  }
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostics."
  type        = string
}

variable "subnet_name" {
  description = "The Name of the Subnet."
  type        = string
}
