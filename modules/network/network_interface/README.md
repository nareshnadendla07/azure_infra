# Azure Network Interface (NIC) Terraform Module

This Terraform module provisions an Azure Network Interface (NIC) with optional diagnostic settings, public IP attachment, and custom IP configurations.

---

## ✅ Features

- Deploys an Azure Network Interface (NIC)
- Supports both static and dynamic private IP allocation
- Optional public IP association
- Accelerated networking support
- Enables Azure Monitor diagnostic settings to Log Analytics or Storage

---

## 📦 Module Usage

```hcl
module "nic" {
  source                        = "../modules/network/nic"

  nic_name                      = "example-nic"
  location                      = "East US"
  resource_group_name           = "example-rg"
  subnet_id                     = module.vnet.subnet_ids["example-subnet"]
  public_ip_address_id          = module.public_ip.id
  private_ip_allocation_method  = "Dynamic" # or "Static"
  private_ip_address            = null       # Set if using Static
  accelerated_networking_enabled = true
  primary                       = true
  log_analytics_workspace_id    = module.log_analytics.workspace_id
  storage_account_id            = module.storage.id

  tags = {
    environment = "dev"
    owner       = "team-network"
  }
}
```

---

## 🔧 Input Variables

| Name                         | Description                                             | Type      | Default   | Required |
|------------------------------|---------------------------------------------------------|-----------|-----------|----------|
| `nic_name`                   | Name of the NIC                                         | `string`  | n/a       | ✅        |
| `location`                   | Azure location for the NIC                              | `string`  | n/a       | ✅        |
| `resource_group_name`        | Name of the resource group                              | `string`  | n/a       | ✅        |
| `subnet_id`                  | Subnet ID to associate with the NIC                     | `string`  | n/a       | ✅        |
| `public_ip_address_id`       | Optional public IP resource ID                          | `string`  | `""`      | ❌        |
| `private_ip_allocation_method` | `Static` or `Dynamic` allocation for private IP        | `string`  | `Dynamic` | ✅        |
| `private_ip_address`         | Specific private IP (required if using `Static`)        | `string`  | `""`      | ❌        |
| `accelerated_networking_enabled` | Enable accelerated networking                        | `bool`    | `false`   | ❌        |
| `primary`                    | Whether this is the primary IP config                   | `bool`    | `true`    | ❌        |
| `log_analytics_workspace_id` | Log Analytics workspace for diagnostics                 | `string`  | n/a       | ✅        |
| `storage_account_id`         | Storage account ID for diagnostics                      | `string`  | n/a       | ✅        |
| `tags`                       | Tags to apply to the resource                           | `map`     | `{}`      | ❌        |

---

## 📤 Outputs

You can define the following in `output.tf` if needed:

```hcl
output "nic_id" {
  value = azurerm_network_interface.this.id
  description = "The ID of the created Network Interface."
}
```

---

## 🛡️ Security & Compliance

- Use appropriate NSGs with the subnet or attach later
- Ensure diagnostic data is routed to secure storage or Log Analytics workspace
- Use role-based access control (RBAC) to restrict NIC management

---

## 📚 Resources

- [Azure Network Interface Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/network-interface-overview)
- [Terraform azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)
- [Azure Monitor Diagnostic Settings](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
---