# 🌐 Azure WAF Policy Module

This Terraform module creates an **Azure Web Application Firewall (WAF) Policy** that supports both basic and advanced (robust) configurations. It is designed to be reusable across Application Gateways and scalable environments.

---

## 🚀 Features

- 📦 Modular support for **OWASP core rulesets**
- 🔐 Optional **custom rules**, **rule group overrides**, and **exclusions**
- 🔄 Supports both **Detection** and **Prevention** modes
- 🧩 Easily pluggable into Azure Application Gateway via `firewall_policy_id`

---

## 🧩 Usage

```hcl
module "waf_policy" {
  source              = "./modules/waf"
  waf_policy_name     = "my-basic-waf-policy"
  location            = var.location
  resource_group_name = var.resource_group_name

  enable_robust_waf = false # Set true for advanced options
}
```

---

## 📥 Input Variables

| Name                         | Type     | Default     | Description |
|------------------------------|----------|-------------|-------------|
| `waf_policy_name`            | string   | n/a         | Name of the WAF policy |
| `resource_group_name`        | string   | n/a         | Azure Resource Group name |
| `location`                   | string   | n/a         | Azure Region |
| `enable_robust_waf`          | bool     | false       | Enable advanced WAF features |
| `owasp_version`              | string   | "3.2"       | OWASP rule set version |
| `rule_group_overrides`       | list     | `[]`        | Optional OWASP rule overrides |
| `exclusions`                 | list     | `[]`        | Optional request exclusions |
| `custom_rules`               | list     | `[]`        | Optional custom WAF rules |
| `waf_mode`                   | string   | "Prevention"| Detection or Prevention |
| `file_upload_limit_in_mb`    | number   | 100         | Max upload size in MB |
| `max_request_body_size_in_kb`| number   | 128         | Max request body size in KB |
| `tags`                       | map      | `{}`        | Resource tags |

---

## 📤 Outputs

| Name            | Description                        |
|------------------|------------------------------------|
| `waf_policy_id` | The ID of the created WAF policy   |

---

## 🛡️ Security & Compliance

- Built with **least privilege** in mind.
- Optional use of **custom rules** for IP filtering, path-based control, and more.
- Supports **rate limiting** for abuse protection.

---

## 📚 Resources

- [Azure WAF Documentation](https://learn.microsoft.com/en-us/azure/web-application-firewall/)
- [Terraform azurerm_web_application_firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].
Contributions, improvements, and suggestions are welcome!