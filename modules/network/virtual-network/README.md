# Azure Virtual Network (VNet) Terraform Module

This Terraform module creates a secure and production-ready **Azure Virtual Network (VNet)** setup with support for:

- Optional Resource Group creation
- Custom subnets via module
- DDoS Protection Plan (optional)
- Network Watcher (optional or data reference)
- Diagnostic settings for monitoring
- Tagging for governance

---

## ✅ Use Cases

- Reusable VNet module for multiple environments (Dev/Test/Prod)
- Secure VNet setup with observability
- Extendable for NSGs, UDRs, Private Endpoints

---

## 📦 Module Structure

```
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
```

> Note: The module assumes an external `subnet` module is used to define subnets.

---

## 🚀 Example Usage

```hcl
module "vnet" {
  source = "./modules/vnet"

  vnet_name                = "my-vnet"
  location                 = "australiaeast"
  resource_group_name      = "my-network-rg"
  create_resource_group    = true
  address_prefixes         = ["10.0.0.0/16"]
  dns_servers              = []
  tags                     = {
    environment = "dev"
    owner       = "infra-team"
  }

  subnets = [
    {
      name                                 = "subnet-app"
      address_prefixes                     = ["10.0.1.0/24"]
      service_endpoints                    = ["Microsoft.Storage"]
      private_endpoint_network_policies    = "Disabled"
      private_link_service_network_policies = "Enabled"
    }
  ]

  create_ddos_plan           = true
  ddos_plan_name             = "my-ddos"
  create_network_watcher     = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  storage_account_id         = azurerm_storage_account.logs.id
}
```

---

## 📥 Input Variables

| Name                         | Type          | Description                                                    | Default        |
|------------------------------|---------------|----------------------------------------------------------------|----------------|
| `vnet_name`                  | `string`      | Name of the Virtual Network                                    | n/a            |
| `location`                   | `string`      | Azure Region                                                   | n/a            |
| `resource_group_name`        | `string`      | Name of the Resource Group                                     | n/a            |
| `create_resource_group`      | `bool`        | Whether to create the Resource Group                           | `false`        |
| `address_prefixes`           | `list(string)`| Address space for the VNet                                     | n/a            |
| `dns_servers`                | `list(string)`| Optional custom DNS servers                                    | `[]`           |
| `tags`                       | `map(string)` | Tags to apply to all resources                                 | `{}`           |
| `create_ddos_plan`           | `bool`        | Whether to create a DDoS Protection Plan                       | `false`        |
| `ddos_plan_name`             | `string`      | Name of the DDoS Protection Plan                               | `"default-ddos-plan"` |
| `create_network_watcher`     | `bool`        | Whether to create a custom Network Watcher                    | `false`        |
| `log_analytics_workspace_id` | `string`      | Log Analytics Workspace ID for diagnostics                     | n/a            |
| `storage_account_id`         | `string`      | Storage Account ID for diagnostic logs                         | n/a            |
| `subnets`                    | `list(object)`| Subnet configuration (delegation, endpoints, etc.)             | `[]`           |

---

## 📤 Outputs

| Name                   | Description                                 |
|------------------------|---------------------------------------------|
| `virtual_network_id`   | ID of the Virtual Network                   |
| `vnet_name`            | Name of the Virtual Network                 |
| `address_prefixes`     | Address space used by the VNet              |
| `resource_group_name`  | Name of the Resource Group                  |
| `resource_group_id`    | ID of the Resource Group                    |
| `location`             | Azure region                                |
| `subnet_ids`           | Map of subnet names to IDs (via `vnet`)     |
| `subnet_name_id_map`   | Map of subnet names to IDs (via `subnet` module) |

---

## ⚠️ Notes

- If `create_network_watcher = false`, the module assumes the default `NetworkWatcherRG` and `NetworkWatcher_<region>` already exist.
- This module does **not** include NSG or UDR setup — use a separate module or extend this one.
- Diagnostic logs are sent to both Log Analytics and Storage for redundancy.

---

## 🛡️ Security & Compliance

- Ensure RBAC is set on Log Analytics and Storage accounts
- Follow Azure naming conventions and tag policies
- Enable DDoS Standard only when needed (adds cost)

---

## 📚 Resources

- [Azure Virtual Network documentation](https://learn.microsoft.com/en-us/azure/virtual-network/)
- [Terraform azurerm provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!