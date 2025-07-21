
# 🌐 Azure Private Endpoint Module

This Terraform module manages **Azure Private Endpoints** and associated **Private DNS Zone Groups**, allowing secure, private connectivity to Azure PaaS services or custom resources.

---

## 📦 Module Features

- Creates an Azure Private Endpoint in a specified subnet.
- Supports dynamic private service connections.
- Optionally associates Private DNS Zones using DNS Zone Groups.
- Supports existing endpoint reference mode with DNS zone group attachment.

---

## ✅ Requirements

- Terraform >= 1.0.0
- AzureRM Provider >= 3.0

---

## 🚀 Usage

### Create New Private Endpoint with DNS Zone Association

```hcl
module "private_endpoint" {
  source                         = "./modules/network/private-endpoint"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  subnet_resource_id             = module.vnet.subnet_ids["private_subnet"]
  private_endpoint_name          = "pe-sql"
  private_dns_zone_group_name    = "sql-dns-group"

  ip_configurations = [
    {
      name               = "ipconfig1"
      private_ip_address = "10.0.0.10"
    }
  ]

  private_link_service_connections = [
    {
      name                           = "sql-pe-conn"
      private_connection_resource_id = var.sql_server_id
      subresource_names              = ["sqlServer"]
    }
  ]

  private_dns_zone_resource_ids = [
    "/subscriptions/xxxx/resourceGroups/rg/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
  ]

  tags = var.tags
}
```

### Attach Private DNS Zone Group to Existing Private Endpoint

```hcl
module "existing_private_endpoint_dns" {
  source                      = "./modules/network/private-endpoint-dns"
  private_endpoint_name       = "pe-existing"
  resource_group_name         = "rg-existing"
  dns__zone_group_name        = "dns-zone-group-existing"
  private_dns_resource_ids    = [
    "/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
  ]
}
```

---

## 📥 Input Variables

| Name                              | Type            | Description                                                                 | Required |
|-----------------------------------|-----------------|-----------------------------------------------------------------------------|----------|
| `location`                        | `string`        | Azure region for the endpoint                                               | ✅ Yes   |
| `resource_group_name`             | `string`        | Resource group name                                                         | ✅ Yes   |
| `private_endpoint_name`           | `string`        | Name of the private endpoint                                                | ✅ Yes   |
| `subnet_resource_id`              | `string`        | Subnet ID where endpoint will be created                                    | ✅ Yes   |
| `ip_configurations`               | `list(object)`  | List of IP configurations (name & private_ip_address)                       | Optional |
| `private_link_service_connections`| `list(object)`  | List of private link service connections                                    | Optional |
| `private_dns_zone_group_name`     | `string`        | Name of the private DNS zone group                                          | Optional |
| `private_dns_zone_resource_ids`   | `list(string)`  | List of Private DNS zone resource IDs to associate                          | Optional |
| `tags`                            | `map(string)`   | Resource tags                                                               | Optional |

---

## 📤 Outputs

You may optionally export values like:

```hcl
output "private_endpoint_id" {
  value = azurerm_private_endpoint.this.id
}

output "private_dns_zone_group_id" {
  value = azurerm_private_dns_zone_group.this.id
}
```

---

## 🛡️ Security & Compliance

- Ensures private traffic routing through Azure backbone.
- No public internet exposure of services.
- DNS zone mapping enables internal name resolution.

---

## 📚 Resources

- [Azure Private Endpoint Docs](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
- [Terraform azurerm_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Terraform azurerm_private_dns_zone_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_group)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!

---
