variable "location" {
  description = "Location for all resources."
  type        = string  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "enable_proximity_placement_group" {
  description = "Manages a proximity placement group for virtual machines, virtual machine scale sets and availability sets."
  type = bool
}

variable "proximity_name" {
  description = "The name of the proximity group."
  type        = string
  default     = ""
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}