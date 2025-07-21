# Azure Storage Container Module

This Terraform module provisions Azure Storage Containers and optionally configures Immutability Policies for them.

## Resources Created

- `azurerm_storage_container`
- Module: `immutability-policy`

## Features

- Creates multiple storage containers using `for_each`
- Supports setting metadata, encryption scope, and access type
- Supports enabling immutability policies via a submodule

## Input Variables

### `containers`
A map of containers to be created with their configurations.

Example:
```hcl
containers = {
  "logs" = {
    container_access_type        = "private"
    default_encryption_scope     = "blobEncryptionScope"
    metadata                     = {
      environment = "dev"
    }
    immutability_policy_properties = {
      immutability_period_since_creation_in_days = 30
      allow_protected_append_writes              = true
      allow_protected_append_writes_all          = false
    }
  }
}
```

### `storage_account_id`
The resource ID of the storage account where containers will be created.

## Module: `immutability-policy`

This is an optional submodule that sets immutability policies for the containers.

- **Input:** `containers` map (same as above)
- **Input:** `storage_container_resource_manager_id` for each container

## Example Usage

```hcl
module "storage_container" {
  source = "./modules/storage-container"

  containers = var.containers
  storage_account_id = azurerm_storage_account.example.id
}
```

## Notes

- `immutability-policy` submodule should exist at `./immutability-policy`
- Each container configuration can optionally include `immutability_policy_properties`

## 🛡️ Security & Compliance
This module does not handle any credentials directly. Ensure appropriate IAM policies and access controls are in place when working with Azure Storage resources.

## 📚 Resources
- [Terraform azurerm_storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
- [Terraform azurerm_storage_container_immutability_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container_immutability_policy)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
