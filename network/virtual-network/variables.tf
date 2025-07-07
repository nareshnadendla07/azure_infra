variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "location" {
  description = "The location/region of the virtual network."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "create_ddos_plan" {
  description = "Set to true to create a DDoS protection plan, otherwise set to false."
  type        = bool
  default     = false
}

variable "ddos_plan_name" {
  description = "The name of the DDoS protection plan if it is created."
  type        = string
  default     = "default-ddos-plan"
}

variable "create_network_watcher" {
  description = "Set to true to create a network watcher, otherwise set to false."
  type        = bool
  default     = false
}

variable "create_resource_group" {
  description = "Set to true to create a resource group, otherwise set to false to use an existing one."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
}

variable "address_prefixes" {
  description = "The address space prefixes for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to create."
  type = list(object({
    name                                 = string
    address_prefixes                     = list(string)
    service_endpoints                    = list(string)
    delegation                           = optional(object({
      name         = string
      service_name = string
      actions      = list(string)
    }))
    private_endpoint_network_policies    = string
    private_link_service_network_policies = string
  }))
  default = []
}

variable "dns_servers" {
  description = "List of DNS servers"
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}

variable "storage_account_id" {
  description = "The name of the storage account to store all monitoring logs"  
  type        = string
}