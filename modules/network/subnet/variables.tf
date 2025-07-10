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

variable "virtual_network_name" {
  description = "The name of the parent virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where the virtual network is located."
  type        = string
}
