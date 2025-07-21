#########################################
## Web Application Firewall Policy Module
#########################################

resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.waf_policy_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Managed Rules: OWASP version can vary based on basic or robust mode
  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = var.owasp_version

      dynamic "rule_group_override" {
        for_each = var.enable_robust_waf ? var.rule_group_overrides : []
        content {
          rule_group_name = rule_group_override.value.rule_group_name

          dynamic "rule" {
            for_each = rule_group_override.value.rules
            content {
              id      = rule.value.id
              enabled = rule.value.enabled
              action  = rule.value.action
            }
          }
        }
      }
    }

    dynamic "exclusion" {
      for_each = var.enable_robust_waf ? var.exclusions : []
      content {
        match_variable          = exclusion.value.match_variable
        selector                = exclusion.value.selector
        selector_match_operator = exclusion.value.selector_match_operator
      }
    }
  }

  dynamic "custom_rules" {
    for_each = var.enable_robust_waf ? var.custom_rules : []
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type

      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          match_variables {
            variable_name = match_conditions.value.variable_name
            selector      = lookup(match_conditions.value, "selector", null)
          }
          operator           = match_conditions.value.operator
          negation_condition = lookup(match_conditions.value, "negation_condition", false)
          match_values       = match_conditions.value.match_values
        }
      }

      action = custom_rules.value.action

      dynamic "rate_limit_threshold" {
        for_each = custom_rules.value.rule_type == "RateLimitRule" ? [1] : []
        content {
          threshold = custom_rules.value.rate_limit_threshold
        }
      }
    }
  }

  policy_settings {
    enabled                     = true
    mode                        = var.waf_mode
    request_body_check          = true
    file_upload_limit_in_mb     = var.file_upload_limit_in_mb
    max_request_body_size_in_kb = var.max_request_body_size_in_kb
  }

  tags = var.tags
}
