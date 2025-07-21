# 🚀 Azure Cognitive Services Terraform Module

This Terraform module provisions an **Azure Cognitive Services Account** with diagnostics and role-based access control.

## 📦 Resources Created

- `azurerm_cognitive_account`: Creates the Cognitive Services account
- `azurerm_monitor_diagnostic_setting`: Enables logging and metrics to Log Analytics or Storage
- `azurerm_role_assignment`: Assigns the "Cognitive Services Account Contributor" role

## 🎯 Features

- Supports SystemAssigned managed identity
- Enables advanced diagnostics (Audit, Trace, Usage logs)
- Role-based access assignment for automation or user accounts

## 🧾 Example Usage

```hcl
module "cognitive_account" {
  source = "./modules/cognitive"

  cognitive_name               = "mycognitiveacct"
  location                     = "East US"
  resource_group_name          = "rg-ai-resources"
  kind                         = "CognitiveServices"
  sku_name                     = "S0"
  public_network_access_enabled = true
  custom_subdomain_name        = "mycustomdomain"
  default_action               = "Deny"
  log_analytics_workspace_id   = azurerm_log_analytics_workspace.example.id
  storage_account_id           = azurerm_storage_account.example.id
  tags                         = { environment = "dev" }
}
```

## 🛡️ Security & Compliance

- Ensures access is granted only to specific identities via `azurerm_role_assignment`
- Supports private networking via `network_acls`
- Logs all actions via diagnostic settings

## 📤 Outputs

_None defined explicitly, but you can expose outputs such as the Cognitive Account ID if needed._

## 📚 Resources

- [Azure Cognitive Services Docs](https://learn.microsoft.com/en-us/azure/cognitive-services/)
- [Terraform azurerm_cognitive_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!