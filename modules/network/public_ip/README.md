# Azure Public IP Terraform Module

This Terraform module creates a configurable Azure Public IP address resource.

## ✅ Features

- Create **IPv4 or IPv6** Public IPs
- Choose between **Static** or **Dynamic** allocation
- Supports **Standard** or **Basic** SKU
- Availability Zone support
- Outputs for ID, IP address, and FQDN

---

## 📦 Usage

```hcl
module "public_ip" {
  source                        = "../modules/network/public-ip"
  public_ip_name                = "my-public-ip"
  location                      = "australiaeast"
  resource_group_name           = "my-network-rg"
  public_ip_sku_name            = "Standard"
  public_ip_sku_tier            = "Regional"
  public_ip_allocation_method   = "Static"
  public_ip_address_version     = "IPv4"
  idle_timeout_in_minutes       = 10
  zones                         = ["1", "2", "3"]
  tags = {
    environment = "dev"
    owner       = "network-team"
  }
}
```

---

## 🔧 Variables

| Name                         | Description                                           | Type           | Default  | Required |
|------------------------------|-------------------------------------------------------|----------------|----------|----------|
| `public_ip_name`             | Name of the Public IP                                 | `string`       | n/a      | ✅       |
| `location`                   | Azure region                                          | `string`       | n/a      | ✅       |
| `resource_group_name`        | Resource Group name                                   | `string`       | n/a      | ✅       |
| `tags`                       | Resource tags                                         | `map(string)`  | `{}`     | ✅       |
| `public_ip_sku_name`         | SKU name: `Basic` or `Standard`                      | `string`       | n/a      | ✅       |
| `public_ip_sku_tier`         | SKU tier: `Regional` or `Global`                     | `string`       | `Regional`| ❌      |
| `public_ip_allocation_method`| IP allocation method: `Static` or `Dynamic`           | `string`       | n/a      | ✅       |
| `public_ip_address_version`  | IP version: `IPv4` or `IPv6`                          | `string`       | `IPv4`   | ❌       |
| `idle_timeout_in_minutes`    | Idle timeout duration in minutes                      | `number`       | `4`      | ❌       |
| `zones`                      | List of availability zones (e.g. `["1", "2", "3"]`)   | `list(string)` | `[]`     | ❌       |

---

## 📤 Outputs

| Name              | Description                         |
|-------------------|-------------------------------------|
| `public_ip_id`    | The ID of the Public IP             |
| `public_ip_address`| The assigned IP address            |
| `public_ip_fqdn`  | Fully Qualified Domain Name (FQDN)  |

---

## 🛡️ Security & Compliance

- Ensure Public IPs are used only where required (e.g. jumpbox, load balancer).
- Follow Azure security best practices for exposing resources to the internet.

---

## 📚 Resources

- [Azure Public IP Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses)
- [Terraform azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!