variable "domain_name" {
  description = "The domain name to join."
  type        = string
}

variable "ou_path" {
  description = "The OU path in the domain."
  type        = string
}

variable "domain_user" {
  description = "The domain user with permissions to join the domain."
  type        = string
}

variable "domain_password" {
  description = "The password for the domain user."
  type        = string
  sensitive   = true
}

variable "virtual_machines" {
  description = "A map of virtual machines with their IDs."
  type        = map(object({
    vm_id = string
  }))
}
