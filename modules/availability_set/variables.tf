variable "virtual_machine_name" {
  description = "The name of the virtual machine."
  default     = ""
}

variable "location" {
  description = "Location for all resources."
  type        = string  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "platform_fault_domain_count" {
  description = "Specifies the number of fault domains that are used"
  default     = 2
}
variable "platform_update_domain_count" {
  description = "Specifies the number of update domains that are used"
  default     = 5
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "proximity_name" {
  description = "The name of the proximity group."
  type        = string
  default     = ""
}

variable "availability_set_name" {
  description = "The name of the availability set"
  type        = string

}

variable "proximity_placement_group_id" {
  description = "value"
  type = string
  
}