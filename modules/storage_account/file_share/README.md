# 📁 Azure Storage File Share Module

This Terraform module provisions Azure Storage File Shares within a specified Storage Account.

## 📦 Resources Created

- `azurerm_storage_share`

## 🧩 Usage

```hcl
module "file_shares" {
  source              = "./modules/storage-file-share"
  storage_account_id  = azurerm_storage_account.example.id
  file_shares = [
    {
      name    = "share1"
      quota   = 5120
      metadata = {
        environment = "dev"
      }
    },
    {
      name    = "share2"
      quota   = 10240
      metadata = {
        environment = "prod"
      }
    }
  ]
}
```

## 🔧 Input Variables

| Name                | Description                                      | Type   | Required |
|---------------------|--------------------------------------------------|--------|----------|
| `storage_account_id`| The ID of the storage account                    | string | ✅ Yes    |
| `file_shares`       | A list of maps defining file share configuration | list(map(object)) | ✅ Yes |

Each file share in `file_shares` should contain:
- `name` – Name of the file share
- `quota` – Quota (in GB)
- `metadata` – Optional metadata key-value pairs

## ✅ Example

Creates two file shares named `share1` and `share2` with custom quotas and metadata.

## 🛡️ Security & Compliance

Ensure proper role-based access control (RBAC) and access keys are used for interacting with file shares.

## 📚 Resources

- [Terraform azurerm_storage_share Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)
- [Azure Storage File Shares](https://learn.microsoft.com/en-us/azure/storage/files/)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!