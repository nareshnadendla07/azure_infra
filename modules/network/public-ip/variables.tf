variable "public_ip_name" {
  description = "The name of the Public IP Address."
  type        = string
}

variable "public_ip_allocation_method" {
  description = "The public IP address allocation method."
  type        = string
  validation {
    condition     = contains(["Dynamic", "Static"], var.public_ip_allocation_method)
    error_message = "Invalid public IP allocation method. Must be 'Dynamic' or 'Static'."
  }
}

variable "zones" {
  description = "A list of availability zones denoting the IP allocated for the resource needs to come from."
  type        = list(string)
  validation {
    condition     = alltrue([for zone in var.zones : contains(["1", "2", "3"], zone)])
    error_message = "Invalid zone. Must be '1', '2', or '3'."
  }
}

variable "public_ip_address_version" {
  description = "IP address version."
  type        = string
  validation {
    condition     = contains(["IPv4", "IPv6"], var.public_ip_address_version)
    error_message = "Invalid IP address version. Must be 'IPv4' or 'IPv6'."
  }
}

variable "public_ip_sku_name" {
  description = "Name of a public IP address SKU."
  type        = string
  validation {
    condition     = contains(["Basic", "Standard"], var.public_ip_sku_name)
    error_message = "Invalid SKU name. Must be 'Basic' or 'Standard'."
  }
}

variable "public_ip_sku_tier" {
  description = "Tier of a public IP address SKU."
  type        = string
  validation {
    condition     = contains(["Global", "Regional"], var.public_ip_sku_tier)
    error_message = "Invalid SKU tier. Must be 'Global' or 'Regional'."
  }
}

variable "location" {
  description = "Location for all resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "idle_timeout_in_minutes" {
  description = "The idle timeout of the public IP address."
  type        = number
}

variable "tags" {
  description = "Tags of the resource."
  type        = map(string)
  default     = {}
}