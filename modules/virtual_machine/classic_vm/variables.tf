variable "vm_name" {
  description = "The name of the virtual machine to be created."
  type        = string
}

variable "vm_size" {
  description = "Specifies the size for the VMs."
  type        = string
}

variable "image_reference" {
  description = "OS image reference."
  type        = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "os_disk" {
  description = "Specifies the OS disk."
  type        = object({
    name              = string
    caching           = string
    create_option     = string
    managed_disk_type = string
    disk_size_gb      = number
  })
}

variable "data_disks" {
  description = "Specifies the data disk."
  type = list(object({
    lun                   = number
    name                  = string
    create_option         = string
    caching               = string
    write_accelerator     = bool
    managed_disk_type     = string
    disk_size_gb          = number
  }))
  default = []
}

variable "vm_admin_username" {
  description = "Administrator username."
  type        = string
}

variable "vm_admin_password" {
  description = "Administrator password for Windows VM."
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Location for all resources."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags of the resource."
  type        = map(string)
  default     = {}
}

variable "os_type" {
  description = "The chosen OS type."
  type        = string
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "OS type must be either 'Windows' or 'Linux'."
  }
}

variable "disable_password_authentication" {
  description = "Specifies whether password authentication should be disabled."
  type        = bool
  default     = false
}

variable "provision_vm_agent" {
  description = "Indicates whether virtual machine agent should be provisioned on the virtual machine."
  type        = bool
  default     = true
}

variable "enable_automatic_updates" {
  description = "Indicates whether Automatic Updates is enabled for the Windows virtual machine."
  type        = bool
  default     = true
}

variable "time_zone" {
  description = "Specifies the time zone of the virtual machine."
  type        = string
  default     = ""
}

variable "win_rm" {
  description = "Specifies the Windows Remote Management listeners."
  type        = list(object({
    protocol = string
    port     = number
  }))
  default = []
}

variable "public_keys" {
  description = "The list of SSH public keys used to authenticate with linux based VMs."
  type        = list(object({
    path    = string
    keyData = string
  }))
  default = []
}

variable "network_interface_id" {
  description = "Specifies the network interface of the virtual machine."
  type        = string
}
