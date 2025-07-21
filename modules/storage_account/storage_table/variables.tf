variable "storage_account_name" {
  description = "The name of the storage account where the tables will be created."
  type        = string
}

variable "tables" {
  description = "A list of table definitions, each with their own name."
  type = list(object({
    name = string
  }))

  validation {
    condition     = alltrue([for t in var.tables : t.name != ""])
    error_message = "Table names must not be empty."
  }

  default = []
}
