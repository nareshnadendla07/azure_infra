# 📦 Azure Storage Container Immutability Policy Module

This Terraform module manages **Immutability Policies** for Azure Storage Containers. It helps enforce data retention by applying WORM (Write Once Read Many) policies on selected storage containers.

## 🚀 Features

- Creates immutability policies on storage containers.
- Supports:
  - `immutability_period_in_days`
  - `protected_append_writes_all_enabled`
  - `protected_append_writes_enabled`

## 📄 Resource

```hcl
resource "azurerm_storage_container_immutability_policy" "this" {
  for_each = var.containers

  storage_container_resource_manager_id = var.storage_container_resource_manager_id
  immutability_period_in_days           = each.value.immutability_policy_properties.immutability_period_since_creation_in_days
  protected_append_writes_all_enabled   = each.value.immutability_policy_properties.allow_protected_append_writes_all
  protected_append_writes_enabled       = each.value.immutability_policy_properties.allow_protected_append_writes
}
```

## 📥 Input Variables

| Name                                      | Type   | Description                                                               |
|-------------------------------------------|--------|---------------------------------------------------------------------------|
| `containers`                              | map    | Map of containers and their immutability settings.                        |
| `storage_container_resource_manager_id`   | string | Resource ID of the Azure Storage Container.                               |

## 🛡️ Security & Compliance

Immutability policies help protect data against deletion or modification for a specified period, ensuring compliance with data retention regulations.

## 📚 Resources

- [Terraform azurerm_storage_container_immutability_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container_immutability_policy)
- [Azure Storage Container Immutability Docs](https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-policy-overview)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
