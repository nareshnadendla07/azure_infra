# Azure Network Security Group Module

This Terraform module is responsible for creating Azure Network Security Groups (NSGs) with customizable security rules and associating these NSGs with specified subnets within a virtual network.

## Features

- **NSG Creation**: Automatically creates NSGs with defined security rules for each subnet.
- **NSG Association**: Associates each NSG with a corresponding subnet, ensuring the security rules are applied.

## Usage

To incorporate this module into your Terraform setup, follow the steps below:

### Module Integration

```hcl
module "azure_nsg" {
  source               = "./path_to_module"
  location             = "East US"
  resource_group_name  = "your_resource_group"
  subnets              = var.subnets
  tags                 = var.tags
}
```

### Provider Configuration

Ensure that the Azure provider is configured:

```hcl
provider "azurerm" {
  features {}
}
```

### Variables

You need to declare the following variables in your Terraform configuration:

- `location`: Specifies the Azure region where the NSGs will be created.
- `resource_group_name`: Specifies the name of the resource group.
- `subnets`: A map of subnets including NSG rules and address prefixes.
- `tags`: A map of tags to apply to all resources.

Example structure for the `subnets` variable:

```hcl
variable "subnets" {
  description = "Details of subnets and their NSG settings."
  type = map(object({
    subnet_address_prefix = list(string)
    nsg_inbound_rules     = list(list(string))  // Format: [[rule_name, priority, direction, access, protocol, port_range, source_prefix, dest_prefix]]
    nsg_outbound_rules    = list(list(string))
  }))
}
```

### Resources

- **azurerm_network_security_group**: Creates a security group for each subnet entry.
- **azurerm_subnet_network_security_group_association**: Associates the created NSG with a specified subnet.

### Outputs

Consider defining outputs for easy reference to NSG IDs and their associations:

```hcl
output "nsg_ids" {
  value = { for nsg in azurerm_network_security_group.nsg : nsg.key => nsg.value.id }
  description = "Map of subnet keys to NSG IDs."
}

output "nsg_associations" {
  value = { for assoc in azurerm_subnet_network_security_group_association.nsg-assoc : assoc.key => assoc.value.id }
  description = "Map of subnet keys to NSG association IDs."
}
```

## Considerations

- Verify the NSG rules to ensure they do not unintentionally block required traffic.
- Review and manage NSG priorities to avoid conflicts between multiple rules.
- Ensure your configuration aligns with Azure best practices and compliance requirements for network security.

---

## 🛡️ Security & Compliance

- NSG rules should be reviewed for least privilege access.
- Avoid overlapping rules or overly permissive configurations (e.g., `*` for source/destination).
- Diagnostic settings can be enabled to log security events to Log Analytics or Storage for auditing.
- Subnet associations should be monitored to ensure NSGs are applied consistently.
- Use Azure Policy and Defender for Cloud to enforce secure networking standards across environments.

---

## 📚 Resources

- [Azure Network Security Groups Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
- [Terraform azurerm_network_security_group Resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)
- [Best Practices for NSGs](https://learn.microsoft.com/en-us/azure/networking/network-security-best-practices)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!