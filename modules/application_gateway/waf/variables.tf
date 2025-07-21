variable "waf_policy_name" {
  description = "Name of the Web Application Firewall (WAF) policy."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which to create the WAF policy."
  type        = string
}

variable "location" {
  description = "Azure region for the WAF policy."
  type        = string
}

variable "enable_robust_waf" {
  description = "Enable advanced WAF settings including custom rules and overrides."
  type        = bool
  default     = false
}

variable "owasp_version" {
  description = "OWASP version to use for managed WAF rules (e.g., 3.2)."
  type        = string
  default     = "3.2"
}

variable "rule_group_overrides" {
  description = "Optional list of OWASP rule group overrides."
  type = list(object({
    rule_group_name = string
    rules = list(object({
      id      = string
      enabled = bool
      action  = string
    }))
  }))
  default = []
}

variable "exclusions" {
  description = "Optional list of exclusions to match variables from WAF inspection."
  type = list(object({
    match_variable          = string
    selector                = string
    selector_match_operator = string
  }))
  default = []
}

variable "custom_rules" {
  description = "Optional list of custom WAF rules for match or rate limiting."
  type = list(object({
    name      = string
    priority  = number
    rule_type = string
    match_conditions = list(object({
      variable_name      = string
      selector           = optional(string)
      operator           = string
      match_values       = list(string)
      negation_condition = optional(bool)
    }))
    action               = string
    rate_limit_threshold = optional(number)
  }))
  default = []
}

variable "waf_mode" {
  description = "WAF mode. Options: Detection or Prevention."
  type        = string
  default     = "Prevention"
}

variable "file_upload_limit_in_mb" {
  description = "Maximum file upload size (MB)."
  type        = number
  default     = 100
}

variable "max_request_body_size_in_kb" {
  description = "Maximum request body size (KB)."
  type        = number
  default     = 128
}

variable "tags" {
  description = "Resource tags to apply."
  type        = map(string)
  default     = {}
}
