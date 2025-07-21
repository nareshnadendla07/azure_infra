
# Terraform Module: Azure Application Security Group (ASG)

This Terraform module creates an **Azure Application Security Group (ASG)** and associates it with a **Network Interface (NIC)**.

## 🚀 Features

- Creates an Azure ASG in a specified resource group and region.
- Associates the ASG with a provided network interface.

## 📦 Resources Created

- `azurerm_application_security_group`
- `azurerm_network_interface_application_security_group_association`

## 📌 Usage Example

```hcl
module "application_security_group" {
  source = "../modules/network/asg"

  name                  = "my-asg"
  location              = "East US"
  resource_group_name   = "my-resource-group"
  network_interface_id  = azurerm_network_interface.nic.id

  tags = {
    Environment = "dev"
    Owner       = "network-team"
  }
}
```

## 🔧 Input Variables

| Name                   | Type     | Description                                         | Required |
|------------------------|----------|-----------------------------------------------------|----------|
| `name`                 | string   | The name of the ASG.                                | ✅ Yes   |
| `location`             | string   | The Azure region where ASG is created.              | ✅ Yes   |
| `resource_group_name`  | string   | The name of the resource group.                     | ✅ Yes   |
| `tags`                 | map      | A map of tags to assign to the resource.            | ❌ No    |
| `network_interface_id` | string   | The ID of the NIC to associate with the ASG.        | ✅ Yes   |

## 📤 Outputs

> You can define outputs if needed, for example:

```hcl
output "asg_id" {
  value = azurerm_application_security_group.asg.id
}
```

## 🛡️ Security & Compliance

- Follows least-privilege principle by applying scoped ASG rules.
- Ensure ASGs are monitored via NSGs and diagnostics.

## 📚 Resources

- [Azure Application Security Groups](https://learn.microsoft.com/en-us/azure/virtual-network/application-security-groups)
- [Terraform azurerm_application_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].
Contributions, improvements, and suggestions are welcome!
