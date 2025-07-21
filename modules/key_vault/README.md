
# 🔐 Terraform Azure Key Vault with Conditional Keys and Access Policies

This Terraform module deploys an **Azure Key Vault** with support for dynamic access policies and **optional creation of encryption keys and certificates**, tailored to suit different environments or subscriptions.

---

## 🚀 Features

- Creates an Azure Key Vault with advanced configuration
- Supports access policies for:
  - Azure AD Users
  - Azure AD Groups
  - Service Principals
- Supports conditional creation of:
  - Disk Encryption Key
  - MSSQL Encryption Key (optional)
  - Storage Encryption Key (optional)
  - Certificate Upload (optional)
- Enables diagnostic settings for Azure Monitor
- Centralized key vault permissions
- Customizable and reusable across subscriptions

---

## 🧩 Usage

```hcl
module "keyvault" {
  source = "./modules/keyvault"

  key_vault_name        = "my-kv"
  location              = "East US"
  resource_group_name   = "my-rg"
  key_vault_sku_pricing_tier = "standard"

  enable_mssql_key     = true
  enable_storage_key   = false
  enable_certificate   = false

  secrets = {
    "sql-password" = "supersecret"
  }

  access_policies = [
    {
      azure_ad_user_principal_names = ["user1@domain.com"]
      key_permissions               = ["Get", "List"]
      secret_permissions            = ["Get", "List"]
    }
  ]

  tags = {
    environment = "dev"
  }
}
```

---

## ⚙️ Inputs

| Name                     | Type    | Default | Description |
|--------------------------|---------|---------|-------------|
| `enable_mssql_key`       | bool    | false   | Whether to create MSSQL encryption key |
| `enable_storage_key`     | bool    | false   | Whether to create Storage encryption key |
| `enable_certificate`     | bool    | false   | Whether to create certificate |
| `secrets`                | map     | {}      | Map of secrets to store in the Key Vault |
| `access_policies`        | list    | []      | List of access policies |
| `certificate_pfx_file_path` | string | n/a | Path to the PFX file (if certs are enabled) |
| `certificate_password`   | string  | n/a     | Password for the certificate |
| `certificate_subject`    | string  | n/a     | Subject name for the cert |

---

## 🔐 Key Vault Keys

The following keys can be optionally created:

- Disk Encryption Key ✅ (always created)
- MSSQL Encryption Key ✅ *(optional)*
- Storage Encryption Key ✅ *(optional)*
- Certificate Upload ✅ *(optional)*

Use the input variables to toggle them.

---

## 📊 Monitoring

Diagnostic settings are enabled:

- AuditEvent
- AzurePolicyEvaluationDetails
- AllMetrics

Logs are forwarded to Log Analytics.

---

## 🛡️ Security & Compliance

- RBAC and Access Policies for least-privilege
- Secrets sanitized for invalid characters
- Purge protection & soft delete enabled
- Optional certificate upload

---

## 📚 Resources

- [Azure Key Vault Documentation](https://learn.microsoft.com/en-us/azure/key-vault/)
- [Terraform azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
