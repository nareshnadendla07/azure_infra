variable "extension_name" {
  description = "Name of the VM extension"
  type        = string
}

variable "virtual_machines" {
  description = "Map of virtual machine IDs with associated information"
  type        = map(object({
    vm_id = string
  }))
}

variable "publisher" {
  description = "Publisher of the VM extension"
  type        = string
}

variable "type" {
  description = "Type of the VM extension"
  type        = string
}

variable "type_handler_version" {
  description = "Version of the extension handler"
  type        = string
}
variable "command_to_execute" {
  description = "The command to execute."
  type        = string
}
