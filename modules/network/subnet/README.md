### README.md for Terraform Subnet Module

#### Overview
This Terraform module is designed to provision subnets within an existing Azure Virtual Network (VNet). It leverages Terraform to automate the deployment and management of subnets, including configurations for service endpoints, delegations, and network policies.

#### Requirements
- **Terraform:** >= 0.12
- **Provider:** azurerm >= 2.0

#### Module Components

1. **Azure Virtual Network Data Source:** Retrieves existing virtual network details.
2. **Subnets:** Provisions multiple subnets with configurable settings such as address prefixes, service endpoints, and network policies.

#### Usage

```hcl
module "azure_subnets" {
  source               = "../modules/subnets"
  virtual_network_name = "existing-vnet-name"
  resource_group_name  = "existing-resource-group-name"
  subnets              = [
    {
      name                        = "subnet1"
      address_prefixes            = ["10.0.1.0/24"]
      service_endpoints           = ["Microsoft.Sql"]
      delegation                  = {
        name            = "delegation1"
        service_name    = "Microsoft.Sql/servers"
        actions         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
      private_endpoint_network_policies = "Enabled"
    },
    {
      name                        = "subnet2"
      address_prefixes            = ["10.0.2.0/24"]
      private_endpoint_network_policies = "Disabled"
    }
  ]
}
```

#### Variables

- `virtual_network_name` - The name of the existing virtual network.
- `resource_group_name` - The resource group where the virtual network is located.
- `subnets` - List of subnet configurations. Each subnet map can include:
  - `name` - Subnet name.
  - `address_prefixes` - CIDR notation of subnet address ranges.
  - `service_endpoints` - Optional list of services that have endpoints within the subnet.
  - `delegation` - Optional configuration for subnet delegation.
  - `private_endpoint_network_policies` - States whether the private endpoint network policies are enabled or disabled.

#### Outputs

- `subnet_ids` - Resource IDs of the created subnets.

#### Notes

- Ensure the existing virtual network and subnets configurations align with Azure policies and compliance requirements.
- Consider Azure service limits and quotas for subnets and service endpoints for extensive deployments.

This README provides a comprehensive guide to using the subnet module, ensuring users can effectively integrate and utilize the module within their environments. Adjustments can be made to include additional details specific to your organization's usage patterns or policies.

#### 🛡️ Security & Compliance

- Ensure that subnet configurations comply with your organization’s network security policies, especially around:
  - **Private Endpoint Network Policies** and **Private Link Policies**
  - **Service Endpoints** — only enable for trusted services
  - **Delegations** — restrict delegated actions to least privilege
- Apply appropriate **Network Security Groups (NSGs)** separately to secure traffic within and across subnets.
- Use Azure Policy to enforce subnet naming conventions and tag compliance if required.
- Monitor subnet usage with Network Watcher and diagnostic settings at the VNet level.

---

#### 📚 Resources

- [Azure Subnet Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet)
- [Terraform azurerm_subnet Resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
- [Azure Delegated Subnet Docs](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-subnet-delegation-overview)

---

#### 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
