variable "rt_name" {
  description = "The name of the Route Table."
  type        = string
  default     = "my-rt"
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

variable "subnet_name" {
  description = "The Name of the Subnet."
  type        = string
}


variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "infra-team"
  }
}