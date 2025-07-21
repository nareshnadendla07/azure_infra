variable "length" {
  description = "The length of the generated password"
  type        = number
  default     = 16
}

variable "special" {
  description = "Include special characters in the password"
  type        = bool
  default     = true
}

variable "override_special" {
  description = "Special characters to use in the password"
  type        = string
  default     = "!@#$%^&*()_+"
}
