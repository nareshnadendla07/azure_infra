variable "private_endpoint_name" {
  description = "The name of the parent private endpoint. Required if the template is used in a standalone deployment."
  type        = string
}

variable "private_dns_resource_ids" {
  description = "Array of private DNS zone resource IDs. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  validation {
    condition     = length(var.private_dns_resource_ids) >= 1 && length(var.private_dns_resource_ids) <= 5
    error_message = "The private DNS zone resource IDs must contain between 1 and 5 elements."
  }
}

variable "dns__zone_group_name" {
  description = "The name of the private DNS zone group."
  type        = string
  default     = "default"
}
