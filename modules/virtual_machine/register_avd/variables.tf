variable "instances_count" {
  description = "Number of VM extensions to create"
  type        = number
}

variable "virtual_machine_ids" {
  description = "List of VM IDs to apply the extension to"
  type        = list(string)
}

variable "extension_name_prefix" {
  description = "Prefix for the extension name"
  type        = string
  default     = "SessionHostForWindows"
}

variable "publisher" {
  description = "Extension publisher"
  type        = string
  default     = "Microsoft.Powershell"
}

variable "type" {
  description = "Extension type"
  type        = string
  default     = "DSC"
}

variable "type_handler_version" {
  description = "Extension handler version"
  type        = string
  default     = "2.73"
}

variable "auto_upgrade_minor_version" {
  description = "Enable auto-upgrade of minor version"
  type        = bool
  default     = true
}

variable "modules_url" {
  description = "URL to the Configuration.zip file"
  type        = string
}

variable "configuration_function" {
  description = "Configuration function inside the DSC script"
  type        = string
  default     = "Configuration.ps1\\AddSessionHost"
}

variable "host_pool_name" {
  description = "Name of the AVD host pool"
  type        = string
}

variable "registration_token" {
  description = "Registration token for AVD host pool"
  type        = string
}
