variable "storage_account_id" {
  description = "The ID of the storage account where the file shares will be created."
  type        = string
}

variable "file_shares" {
  description = "A list of file shares with their properties."
  type = list(object({
    name             = string
    quota            = number
    access_tier      = string
    enabled_protocol = string
    metadata         = map(string)
  }))
}