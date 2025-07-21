variable "name" {
  description = "The name of the Application Security Group"
  type        = string
}

variable "location" {
  description = "The location where the ASG will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "network_interface_id" {
  description = "The Network interface ID"
  type        = string

}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
}
