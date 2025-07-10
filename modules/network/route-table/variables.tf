variable "rtname" {
  description = "Name given for the hub route table."
  type        = string
}

variable "location" {
  description = "Location for all resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "enable_bgp_propagation" {
  description = "Whether to enable BGP route propagation on the route table."
  type        = bool
  default     = false
}


variable "disable_bgp_route_propagation" {
  description = "Switch to disable BGP route propagation."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags of the resource."
  type        = map(string)
  default     = {}
}

variable "routes" {
  description = "List of basic routes to add to the route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
    has_bgp_override       = bool
  }))
  default = []
}

variable "gateway_routes" {
  description = "Optional set of routes that use advanced hop types like VirtualAppliance"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
    has_bgp_override       = bool
  }))
  default = []
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with this route table."
  type        = list(string)
  default     = []
}
