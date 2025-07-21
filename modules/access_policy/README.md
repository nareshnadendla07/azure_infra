
# 🔐 Azure Key Vault Access Policy Module

This Terraform module creates an **Azure Key Vault Access Policy** for a given principal (user, service principal, or managed identity) with customizable permissions for **keys**, **secrets**, and **certificates**.

---

## ✅ Features

- Creates an access policy in an existing Azure Key Vault
- Assigns permissions for **keys**, **secrets**, and **certificates**
- Permissions are **optional** – pass only what you need

---

## 📦 Resources Created

- `azurerm_key_vault_access_policy`

---

## 🚀 Usage Example

```hcl
module "kv_access_policy" {
  source       = "../modules/keyvault/access-policy"
  key_vault_id = azurerm_key_vault.example.id
  principal_id = azurerm_user_assigned_identity.identity.principal_id

  key_permissions = [
    "Get", "List", "WrapKey", "UnwrapKey"
  ]

  secret_permissions = [
    "Get", "Set", "Delete"
  ]

  certificate_permissions = []
}
```

---

## 🔧 Input Variables

| Name                      | Type         | Description                                               | Default |
|---------------------------|-------------|-----------------------------------------------------------|---------|
| `key_vault_id`           | `string`    | The ID of the Azure Key Vault                             | n/a     |
| `principal_id`           | `string`    | The Object ID of the principal to assign permissions to   | n/a     |
| `secret_permissions`     | `list(string)` | List of secret permissions (optional)                     | `[]`    |
| `key_permissions`        | `list(string)` | List of key permissions (optional)                        | `[]`    |
| `certificate_permissions`| `list(string)` | List of certificate permissions (optional)                | `[]`    |

---

## 📤 Outputs

Example:

```hcl
output "access_policy_id" {
  value       = azurerm_key_vault_access_policy.this.id
  description = "The ID of the Key Vault access policy."
}
```

---

## 🛡️ Security & Compliance

- Follows **least privilege** principle – only assign required permissions.
- Avoid granting full access (e.g., `all`) unless necessary.

---

## 📚 Resources

- [Azure Key Vault Access Policies](https://learn.microsoft.com/en-us/azure/key-vault/general/assign-access-policy)
- [Terraform azurerm_key_vault_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!

---
