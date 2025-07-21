
# 📦 Azure Storage Queue Module

This Terraform module provisions Azure Storage Queues within a specified storage account.

## 🚀 Usage

```hcl
module "storage_queues" {
  source = "./modules/storage-queues"

  storage_account_name = "examplestorageacct"
  queues = [
    {
      name     = "queue1"
      metadata = {
        environment = "dev"
      }
    },
    {
      name     = "queue2"
      metadata = {}
    }
  ]
}
```

## 📥 Input Variables

| Name                  | Type   | Description                                      | Required |
|-----------------------|--------|--------------------------------------------------|----------|
| `storage_account_name`| string | The name of the storage account to use.          | ✅ Yes    |
| `queues`              | list   | List of objects with queue `name` and `metadata`.| ✅ Yes    |

### Example `queues` Variable Format

```hcl
queues = [
  {
    name     = "queue1"
    metadata = {
      environment = "dev"
    }
  },
  {
    name     = "queue2"
    metadata = {}
  }
]
```

## 🔄 Resources Created

- `azurerm_storage_queue`

## 🔐 Security & Compliance

Make sure to configure appropriate IAM roles to restrict access to queues. For production, avoid exposing queues publicly and configure logging and monitoring.

## 📚 Resources

- [Terraform azurerm_storage_queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue)
- [Azure Storage Queues documentation](https://learn.microsoft.com/en-us/azure/storage/queues/)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
