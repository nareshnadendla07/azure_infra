# Azure WAF Policy Terraform Module

This Terraform module allows you to deploy a configurable Azure Web Application Firewall (WAF) policy. It supports custom rules, OWASP settings, exclusions, and advanced WAF configurations.

---

## ✅ Features

- Deploy WAF Policy in `Detection` or `Prevention` mode
- Set custom OWASP ruleset version (e.g., 3.2)
- Define custom WAF rules (e.g., rate limiting, match conditions)
- Override managed rule groups
- Add request exclusions (e.g., ignore headers or query params)
- Optional settings for file upload size and request body limit

---

## 📦 Usage

```hcl
module "waf_policy" {
  source              = "./modules/waf-policy"
  waf_policy_name     = "my-waf-policy"
  location            = var.location
  resource_group_name = var.resource_group_name

  waf_mode                    = "Prevention"
  owasp_version               = "3.2"
  enable_robust_waf           = true
  file_upload_limit_in_mb     = 100
  max_request_body_size_in_kb = 128

  rule_group_overrides = [
    {
      rule_group_name = "SQLI"
      rules = [
        {
          id      = "942100"
          enabled = false
          action  = "Log"
        }
      ]
    }
  ]

  exclusions = [
    {
      match_variable          = "RequestHeaderNames"
      selector                = "X-Custom-Header"
      selector_match_operator = "Equals"
    }
  ]

  custom_rules = [
    {
      name      = "Block-Bad-IP"
      priority  = 1
      rule_type = "MatchRule"
      action    = "Block"

      match_conditions = [
        {
          variable_name = "RemoteAddr"
          operator      = "IPMatch"
          match_values  = ["192.168.1.1"]
        }
      ]
    }
  ]
}
```

---

## 📥 Input Variables

| Name                          | Type   | Description                                                                 | Default     |
|-------------------------------|--------|-----------------------------------------------------------------------------|-------------|
| `waf_policy_name`             | string | Name of the WAF policy.                                                     | –           |
| `resource_group_name`         | string | Azure resource group name.                                                 | –           |
| `location`                    | string | Azure region for the WAF policy.                                           | –           |
| `enable_robust_waf`           | bool   | Enable advanced WAF configuration.                                         | `false`     |
| `owasp_version`               | string | OWASP version for managed rules.                                           | `"3.2"`     |
| `rule_group_overrides`        | list   | List of rule group overrides and actions.                                  | `[]`        |
| `exclusions`                  | list   | List of exclusions from WAF evaluation.                                    | `[]`        |
| `custom_rules`                | list   | Custom WAF rules (e.g. block IPs, rate limit).                             | `[]`        |
| `waf_mode`                    | string | WAF mode (`Prevention` or `Detection`).                                    | `"Prevention"` |
| `file_upload_limit_in_mb`     | number | Maximum file upload size in MB.                                            | `100`       |
| `max_request_body_size_in_kb` | number | Maximum request body size in KB.                                           | `128`       |

---

## 📤 Outputs

| Output Name                  | Description                            |
|------------------------------|----------------------------------------|
| `waf_policy_id`              | The WAF policy resource ID             |
| `waf_policy_name`            | The WAF policy name                    |
| `waf_policy_resource_group`  | The resource group of the WAF policy   |

---

## 🛡️ Security & Compliance

This module leverages Microsoft’s managed WAF rule sets, including the OWASP Core Rule Sets (CRS). It allows for granular exclusions and custom rules for tailored protection. Follow security best practices by:
- Running in `Detection` mode first
- Gradually enabling `Prevention` with logging
- Reviewing Azure Monitor logs via Diagnostic Settings

---

## 📚 Resources

- [Azure WAF Policy Documentation](https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/waf-overview)
- [Terraform azurerm_web_application_firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy)
- [OWASP ModSecurity CRS](https://owasp.org/www-project-modsecurity-core-rule-set/)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].
Contributions, improvements, and suggestions are welcome!