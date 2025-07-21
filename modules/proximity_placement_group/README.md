
# Azure Proximity Placement Group Module

This Terraform module creates an **Azure Proximity Placement Group (PPG)** which helps achieve lower latency and better performance for co-located virtual machines and services such as VMSS and availability sets.

## 📦 Resources Created

- `azurerm_proximity_placement_group`

## 📥 Input Variables

| Name                           | Type     | Description                                                                 | Required |
|--------------------------------|----------|-----------------------------------------------------------------------------|----------|
| `enable_proximity_placement_group` | `bool`    | Toggle to enable or disable the creation of the proximity placement group. | Yes      |
| `proximity_name`              | `string` | Name of the proximity placement group.                                      | Yes      |
| `resource_group_name`         | `string` | Name of the resource group.                                                 | Yes      |
| `location`                    | `string` | Azure region where the resource will be created.                            | Yes      |
| `tags`                        | `map`    | A map of tags to assign to the resource.                                    | No       |

## 📤 Output

This module does not export any output by default. You can add outputs like below in your module if required:

```hcl
output "ppg_id" {
  value = azurerm_proximity_placement_group.appgrp[0].id
}
```

## 🔒 Security

This module does not handle any sensitive data.



## 📚 Resources

- [Terraform AzureRM Provider - Proximity Placement Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/proximity_placement_group)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!