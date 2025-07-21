
# 📦 Azure Storage Table Module

This Terraform module provisions one or more **Azure Storage Tables** within a specified Storage Account.

## 📘 Usage

```hcl
module "storage_table" {
  source = "./modules/storage-table"

  storage_account_name = "examplestorageacct"

  tables = [
    {
      name = "auditTable"
    },
    {
      name = "eventTable"
    }
  ]
}
```

## 📥 Input Variables

| Name                 | Type   | Description                                  | Required |
|----------------------|--------|----------------------------------------------|----------|
| `storage_account_name` | string | Name of the existing Storage Account.         | ✅ Yes   |
| `tables`             | list(object) | List of table definitions with `name`.     | ✅ Yes   |

Example `tables` input:

```hcl
tables = [
  {
    name = "auditTable"
  },
  {
    name = "eventTable"
  }
]
```

## 📤 Output

No outputs defined by default.

## 🔒 Security & Compliance

- This module assumes the storage account is already secured externally.
- No access keys or SAS tokens are exposed by default.

## 📚 Resources

- [Terraform: azurerm_storage_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table)
- [Azure Storage Tables Documentation](https://learn.microsoft.com/en-us/azure/storage/tables/)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
