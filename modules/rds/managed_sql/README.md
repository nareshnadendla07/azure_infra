# Azure SQL Managed Instance Terraform Module

This Terraform module provisions a fully-featured **Azure SQL Managed Instance** (`azurerm_mssql_managed_instance`) along with integrated security, monitoring, and identity features.

---

## 🚀 Features

- Deploys Azure SQL Managed Instance with full configuration options.
- Supports both **System Assigned** and **User Assigned** Managed Identities.
- Enables:
  - Active Directory Administrator
  - Security Alert Policy
  - Vulnerability Assessment
  - Transparent Data Encryption (TDE)
  - Diagnostic Logging
  - Role Assignments
  - Management Lock
  - Advanced Threat Protection

---

## 🔧 Usage

```hcl
module "sqlmi" {
  source = "./modules/sqlmi"

  managed_instance_name         = "my-sqlmi"
  resource_group_name           = "rg-database"
  location                      = "australiaeast"
  sku_name                      = "GP_Gen5_2"
  vcores                        = 2
  storage_size_in_gb            = 64
  subnet_id                     = "/subscriptions/.../subnet/sqlmi-subnet"
  administrator_login           = "sqladminuser"
  administrator_login_password  = "MySecurePassword123!"

  # Optional security features
  active_directory_administrator = {
    login_username              = "admin@domain.com"
    object_id                   = "00000000-0000-0000-0000-000000000000"
    tenant_id                   = "11111111-1111-1111-1111-111111111111"
    azuread_authentication_only = true
  }

  security_alert_policy = {
    enabled                    = true
    email_addresses            = ["secops@domain.com"]
    disabled_alerts            = ["Sql_Injection", "Data_Exfiltration"]
    retention_days             = 30
    storage_account_access_key = null
    storage_endpoint           = null
  }

  vulnerability_assessment = {
    storage_container_path = "https://mystorage.blob.core.windows.net/sqlva"
    recurring_scans = {
      enabled                = true
      email_subscription_admins = true
      emails = ["vaalerts@domain.com"]
    }
  }

  transparent_data_encryption = {
    auto_rotation_enabled = true
    key_vault_key_id      = "https://myvault.vault.azure.net/keys/mykey"
  }

  enable_advanced_threat_protection = true
  advanced_threat_protection_email_addresses = ["threat@domain.com"]

  log_analytics_workspace_id = "/subscriptions/.../loganalytics"
}

## 🔐 Identity
Supports the following:

SystemAssigned

UserAssigned

Combined: SystemAssigned, UserAssigned

## 📌 Inputs

Use the managed_identities object to configure appropriately.

| Name                           | Type          | Description                                | Required |
| ------------------------------ | ------------- | ------------------------------------------ | -------- |
| `managed_instance_name`        | `string`      | Name of the SQL MI                         | ✅ Yes    |
| `resource_group_name`          | `string`      | Name of resource group                     | ✅ Yes    |
| `location`                     | `string`      | Azure region                               | ✅ Yes    |
| `subnet_id`                    | `string`      | Subnet where the SQL MI will be deployed   | ✅ Yes    |
| `administrator_login`          | `string`      | SQL admin username                         | ✅ Yes    |
| `administrator_login_password` | `string`      | SQL admin password                         | ✅ Yes    |
| `sku_name`                     | `string`      | SKU (e.g., `GP_Gen5_2`)                    | ✅ Yes    |
| `vcores`                       | `number`      | Number of vCores                           | ✅ Yes    |
| `storage_size_in_gb`           | `number`      | Storage size in GB                         | ✅ Yes    |
| `security_alert_policy`        | `object`      | Settings for alert policy                  | Optional |
| `vulnerability_assessment`     | `object`      | Settings for vulnerability assessments     | Optional |
| `transparent_data_encryption`  | `object`      | Settings for encryption key and rotation   | Optional |
| `role_assignments`             | `map(object)` | Custom role assignments on the SQL MI      | Optional |
| `log_analytics_workspace_id`   | `string`      | Log Analytics workspace ID for diagnostics | Optional |


## 🔒 Security & Compliance

Uses Azure Policy best practices for TDE, Vulnerability Assessment, and Threat Protection.

Allows optional storage encryption with customer-managed key (CMK).

Role assignments can be scoped tightly and support conditions.

Supports RBAC and AD-based login via AAD admin integration.

## 🧠 Notes
This module assumes that the subnet is pre-configured with correct NSGs and UDRs for SQL MI.

Make sure to enable private DNS zone linking for full functionality if applicable.

When using user-assigned identity, ensure they are properly granted permissions to Key Vault or Storage.

## 📚 Resources
[Azure SQL Managed Instance docs](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/)
[azurerm_mssql_managed_instance Docs](https://learn.microsoft.com/en-us/azure/azure-sql/database/tde-byok-overview)
[Azure Key Vault and TDE integration Docs](https://learn.microsoft.com/en-us/azure/azure-sql/database/tde-byok-overview)


## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!