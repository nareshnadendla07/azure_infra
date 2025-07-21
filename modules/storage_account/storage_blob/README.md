# Azure Storage Blob Module

This Terraform module provisions an Azure Storage Blob within an existing storage account and container.

## 📦 Resources

- `azurerm_storage_blob`

## 📄 Example Usage

```hcl
module "storage_blob" {
  source = "./modules/storage_blob"

  blob_name             = "example.txt"
  storage_account_name  = "mystorageaccount"
  storage_container_name = "mycontainer"
  blob_type             = "Block"
  blob_source           = "path/to/local/file.txt"
}
```

## 📥 Input Variables

| Name                   | Description                                                  | Type   | Required |
|------------------------|--------------------------------------------------------------|--------|----------|
| `blob_name`            | The name of the blob.                                        | string | ✅ Yes   |
| `storage_account_name` | The name of the storage account.                             | string | ✅ Yes   |
| `storage_container_name` | The name of the container in the storage account.          | string | ✅ Yes   |
| `blob_type`            | The type of the blob. Possible values are `Block`, `Page`, `Append`. | string | ✅ Yes   |
| `blob_source`          | The path to the source file that will be uploaded as a blob. | string | ✅ Yes   |

## 🛡️ Security & Compliance

Ensure that uploaded blob files do not contain sensitive information unless proper encryption and access policies are enforced.

## 📚 Resources

- [Terraform azurerm_storage_blob Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!