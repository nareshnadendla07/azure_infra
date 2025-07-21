# 📦 Azure Storage Management Policy Module

This Terraform module manages **Azure Storage Management Policies** for a given storage account. It enables tiering, deletion, and lifecycle management of blobs, snapshots, and versions.

---

## 📁 Resources Created

- `azurerm_storage_management_policy`

---

## 🧩 Usage Example

```hcl
module "storage_management_policy" {
  source              = "./modules/storage-management-policy"
  storage_account_id  = azurerm_storage_account.example.id

  management_policies = [
    {
      name    = "tier-policy"
      enabled = true
      filters = {
        prefix_match = ["logs/"]
        blob_types   = ["blockBlob"]
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days_since_modification_greater_than    = 30
          tier_to_archive_after_days_since_modification_greater_than = 90
          delete_after_days_since_modification_greater_than          = 365
        }
        snapshot = {
          delete_after_days_since_creation_greater_than = 30
        }
        version = {
          change_tier_to_archive_after_days_since_creation = 60
          delete_after_days_since_creation                 = 180
        }
      }
    }
  ]
}
```

---

## 🔧 Input Variables

| Name                  | Type        | Description                                      |
|-----------------------|-------------|--------------------------------------------------|
| `storage_account_id`  | `string`    | ID of the Storage Account.                      |
| `management_policies` | `list(map)` | List of policy definitions with rules and actions. |

---

## ✅ Output

No outputs.

---

## 🛡️ Security & Compliance

- Apply lifecycle rules to reduce storage cost and enforce data retention policies.
- Helps with compliance and archival practices.

---

## 📚 Resources

- [Terraform azurerm_storage_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy)
- [Azure Docs - Management Policies](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-config)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!