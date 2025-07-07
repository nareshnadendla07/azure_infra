variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "my-vnet"
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

variable "create_resource_group" {
  description = "Whether to create the resource group."
  type        = bool
  default     = true
}

variable "address_prefixes" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "Optional list of custom DNS servers."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "infra-team"
  }
}

variable "subnets" {
  description = "List of subnets to create."
  type = list(object({
    name                                 = string
    address_prefixes                     = list(string)
    service_endpoints                    = optional(list(string), [])
    delegation                           = optional(object({
      name                = string
      service_name        = string
      actions             = list(string)
    }))
    private_endpoint_network_policies     = string
    private_link_service_network_policies = string
  }))
  default = [
    {
      name                                 = "subnet-app"
      address_prefixes                     = ["10.0.1.0/24"]
      service_endpoints                    = ["Microsoft.Storage"]
      private_endpoint_network_policies    = "Disabled"
      private_link_service_network_policies = "Enabled"
    }
  ]
}

variable "create_ddos_plan" {
  description = "Whether to create a DDoS Protection Plan."
  type        = bool
  default     = true
}

variable "ddos_plan_name" {
  description = "The name of the DDoS Protection Plan."
  type        = string
  default     = "my-ddos"
}

variable "create_network_watcher" {
  description = "Whether to create a Network Watcher."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostics."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account for logs."
  type        = string
}
