variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Location for all resources."
  type        = string
}

variable "custom_dns_configs" {
  description = "Custom DNS configurations for the private endpoint."
  type = list(object({
    name         = string
    ip_addresses = list(string)
  }))
  default = []
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint resource to create."
  type        = string
}

variable "subnet_resource_id" {
  description = "Resource ID of the subnet where the endpoint needs to be created."
  type        = string
}

variable "ip_configurations" {
  description = "A list of IP configurations for the private endpoint."
  type = list(object({
    name               = string
    private_ip_address = string
  }))
  default = []
}

variable "private_dns_zone_group_name" {
  description = "The name of the private DNS zone group to create if `privateDnsZoneResourceIds` were provided."
  type        = string
  default     = "default"
}

variable "private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}


variable "application_security_group_resource_ids" {
  description = "Application security groups in which the private endpoint IP configuration is included."
  type        = list(string)
  default     = []
}

variable "manual_private_link_service_connections" {
  description = "A grouping of information about the connection to the remote resource. Used when the network admin does not have access to approve connections to the remote resource."
  type = list(object({
    name                    = string
    private_link_service_id = string
    group_ids               = list(string)
    request_message         = string
  }))
  default = []
}

variable "private_link_service_connections" {
  description = "A grouping of information about the connection to the remote resource."
  type = list(object({
    name                           = string    
    subresource_names              = list(string)
    private_connection_resource_id = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to be applied on all resources/resource groups in this deployment."
  type        = map(string)
  default     = {}
}