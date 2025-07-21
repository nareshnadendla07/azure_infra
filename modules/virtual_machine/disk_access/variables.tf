variable "location" {
  description = "Location for all resources."
  type        = string
  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "disk_access_name" {
  description = "The name of the disk access"
  type        = string
}

variable "instances_count" {
  description = "The number of Virtual Machines required."
  default     = 1
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
