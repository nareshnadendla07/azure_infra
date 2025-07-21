variable "nic_name" {
  description = "Name given for the Network Interface."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Network Interface."
  type        = string
}

variable "location" {
  description = "Location for all resources."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the resource."
  type        = map(string)
  default     = {}
}

variable "primary" {
  description = "Specifies whether the IP configuration is primary. Default is true."
  type        = bool
  default     = true
}

variable "private_ip_address" {
  description = "Private IP address of the NIC. Must be specified if allocation method is Static."
  type        = string
  default     = ""
}

variable "private_ip_allocation_method" {
  description = "Private IP allocation method (Static or Dynamic)."
  type        = string
  default     = "Dynamic"
}

variable "public_ip_address_id" {
  description = "IP ID of public IP"
  type = string
  
}

variable "enable_accelerated_networking" {
  description = "Whether accelerated networking is enabled. Default is false."
  type        = bool
  default     = false
}

variable "accelerated_networking_enabled" {
  description = "Whether accelerated networking is enabled. Default is false."
  type        = bool  
}

variable "enable_ip_forwarding" {
  description = "Whether IP forwarding is enabled on this NIC. Default is false."
  type        = bool
  default     = false
}

variable "network_security_group_id" {
  description = "Network Security Group ID associated with the NIC."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}

variable "storage_account_id" {
  description = "The name of the storage account to store all monitoring logs"  
  type        = string
}