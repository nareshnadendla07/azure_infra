# ☁️ Azure Availability Set Module

This Terraform module creates and manages an **Azure Availability Set** for Virtual Machines. Availability Sets are used to increase the availability and reliability of applications by distributing VMs across multiple fault domains and update domains.

## 📦 Resources Created

- `azurerm_availability_set`

## 📥 Input Variables

| Name                          | Description                                                                 | Type     | Default | Required |
|-------------------------------|-----------------------------------------------------------------------------|----------|---------|----------|
| `availability_set_name`       | The name of the Availability Set.                                           | `string` | n/a     | ✅ Yes    |
| `resource_group_name`         | The name of the resource group.                                            | `string` | n/a     | ✅ Yes    |
| `location`                    | The Azure region where the Availability Set should be created.             | `string` | n/a     | ✅ Yes    |
| `platform_fault_domain_count`| Number of fault domains.                                                   | `number` | n/a     | ✅ Yes    |
| `platform_update_domain_count`| Number of update domains.                                                  | `number` | n/a     | ✅ Yes    |
| `proximity_placement_group_id`| The ID of the Proximity Placement Group to link with this Availability Set.| `string` | `null`  | ❌ No     |
| `tags`                        | A map of tags to assign to the resource.                                   | `map`    | `{}`    | ❌ No     |

## 📤 Outputs

| Name                | Description                               |
|---------------------|-------------------------------------------|
| `id`                | The ID of the Availability Set.           |
| `name`              | The name of the Availability Set.         |
| `location`          | The region of the Availability Set.       |

## 🛡️ Security & Compliance

This module ensures your virtual machines are distributed across different fault and update domains to reduce the risk of downtime during maintenance.

## 📚 Resources

- [Azure Availability Sets](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)
- [Terraform azurerm_availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!