# Azure Managed Identity Module

This Terraform module provisions an **Azure User Assigned Managed Identity** and assigns it a specified role.

## 📦 Resources Created

- `azurerm_user_assigned_identity`: Creates a user-assigned managed identity.
- `azurerm_role_assignment`: Assigns a role to the managed identity.

## 📌 Usage

```hcl
module "managed_identity" {
  source = "./modules/managed-identity"

  manaaged_identity_name = "example-identity"
  location               = "East US"
  resource_group_name    = "example-rg"
  role_definition_name   = "Reader"
  tags                   = {
    Environment = "dev"
  }
}
```

## 🔧 Input Variables

| Name                    | Type   | Description                                  | Required |
|-------------------------|--------|----------------------------------------------|----------|
| `manaaged_identity_name`| string | Name of the managed identity.                | ✅ Yes   |
| `location`              | string | Azure region to deploy the resources.        | ✅ Yes   |
| `resource_group_name`   | string | Name of the resource group.                  | ✅ Yes   |
| `role_definition_name`  | string | Role to assign (e.g., `Reader`, `Contributor`).| ✅ Yes |
| `tags`                  | map    | Tags to apply to the resources.              | ❌ No    |

## 📤 Outputs

| Name              | Description                     |
|-------------------|---------------------------------|
| `identity_id`     | The ID of the user-assigned identity |
| `principal_id`    | The principal ID of the identity |

## 🛡️ Security & Compliance

- Use least privilege when assigning roles.
- Avoid reusing identity across subscriptions unless explicitly required.

## 📚 Resources

- [Terraform azurerm_user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity)
- [Terraform azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)
- [Azure Managed Identity Docs](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!