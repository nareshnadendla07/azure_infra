# Terraform Azure Route Table Configuration

This repository contains Terraform code to create and manage Azure Route Tables and Routes. The configuration includes variables for customization and resources for defining route tables and routes.

---

## ✅ Requirements

- **Terraform:** >= 0.12
- **Provider:** azurerm >= 2.0

---

## 📥 Variables

- **`rtname`**: Name given for the hub route table.
- **`location`**: Location for all resources.
- **`resource_group_name`**: The name of the resource group.
- **`disable_bgp_route_propagation`**: Switch to disable BGP route propagation (default: `false`).
- **`tags`**: Tags of the resource (default: `{}`).
- **`routes`**: List of routes with the following attributes:
  - `name`: Name of the route.
  - `address_prefix`: Address prefix for the route.
  - `next_hop_type`: Type of the next hop.
  - `next_hop_in_ip_address`: IP address of the next hop (if `next_hop_type` is `VirtualAppliance`).
- **`gateway_routes`**: List of gateway routes with the same attributes as `routes`.
- **`subnet_ids`**: List of subnet IDs to associate the route table with.

---

## 🚀 Usage

```hcl
module "azure_route_table" {
  source = "path/to/azure_route_table_module"

  rtname              = "example-route-table"
  location            = "East US"
  resource_group_name = "resource-group-name"
  routes = [
    {
      name                   = "route1"
      address_prefix         = "10.0.1.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.1.1"
    },
    {
      name           = "route2"
      address_prefix = "10.0.2.0/24"
      next_hop_type  = "VnetLocal"
    }
  ]
  tags = {
    Environment = "Production"
  }
}
```

---

## 🧱 Resources

- **`azurerm_route_table.this`**: Creates an Azure Route Table with the specified name, location, resource group, and tags. Dynamically adds routes from the `routes` variable.
- **`azurerm_route.this`**: Creates individual routes from the `gateway_routes` variable and associates them with the route table.
- **`azurerm_subnet_route_table_association.this`**: Associates the route table with each given subnet ID.

---

## 🛡️ Security & Compliance

- Ensure route definitions do not unintentionally allow broad access or open traffic to insecure destinations.
- Avoid using `0.0.0.0/0` with `Internet` next hop unless explicitly required and governed.
- Use route propagation settings in compliance with BGP standards in your environment.
- Always tag route tables with metadata for auditing and compliance reporting.

---

## 📚 Resources

- [Azure Route Table Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/manage-route-table)
- [Terraform azurerm_route_table Resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table)
- [Terraform azurerm_route Resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route)
- [Terraform azurerm_subnet_route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association)

---

## 👨‍💻 Author

This module is maintained by [Your Name or GitHub handle].

Feel free to contribute or suggest improvements through issues and pull requests.