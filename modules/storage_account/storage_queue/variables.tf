variable "storage_account_name" {
  description = "The name of the storage account where the queues will be created."
  type        = string
}

variable "queues" {
  description = "A list of queue definitions, each with their own name and optional metadata."
  type        = list(object({
    name     = string
    metadata = map(string)
  }))

  validation {
    condition     = alltrue([for q in var.queues : q.name != ""])
    error_message = "Queue names must not be empty."
  }
}

