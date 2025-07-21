# ☁️ Azure Log Analytics Workspace Terraform Module

This Terraform module provisions an **Azure Log Analytics Workspace** with customizable configurations such as SKU, retention period, and tagging.

---

## 📦 Resources Created

- `azurerm_log_analytics_workspace` - Main workspace for monitoring and log collection.

---

## 🚀 Usage

```hcl
module "log_analytics" {
  source              = "./modules/log_analytics"
  workspace_name      = "my-law"
  location            = "East US"
  resource_group_name = "my-resource-group"
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    environment = "dev"
    owner       = "team-name"
  }
}
```

---

## 📥 Input Variables

| Name                | Type   | Description                                      | Required |
|---------------------|--------|--------------------------------------------------|----------|
| `workspace_name`     | string | Name of the Log Analytics workspace              | ✅ Yes   |
| `location`           | string | Azure region where the workspace will be created | ✅ Yes   |
| `resource_group_name`| string | Name of the resource group                       | ✅ Yes   |
| `sku`                | string | SKU for the workspace (e.g., `PerGB2018`)        | ✅ Yes   |
| `retention_in_days`  | number | Data retention period in days                    | ✅ Yes   |
| `tags`               | map    | Tags to apply to the workspace                   | ❌ No    |

---

## 📤 Outputs

This module does not expose outputs by default. Add outputs in your implementation if needed.

---

## 🛡️ Security & Compliance

- Ensure the workspace is connected to trusted resources only.
- Consider enabling diagnostic settings to collect audit and performance logs from other Azure services.

---

## 📚 Resources

- [Terraform Azurerm Provider: `azurerm_log_analytics_workspace`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace)
- [Azure Log Analytics Overview](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-overview)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
