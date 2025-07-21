
# 🔐 Azure Role Assignment Module

This Terraform module creates an Azure Role Assignment using the `azurerm_role_assignment` resource. It's useful for assigning RBAC roles to users, groups, service principals, or managed identities.

---

## 📦 Resource Created

- `azurerm_role_assignment`

---

## 🚀 Usage

```hcl
module "role_assignment" {
  source              = "./modules/role-assignment"

  scope               = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/my-rg"
  role_definition_name = "Contributor"
  principal_id        = "00000000-0000-0000-0000-000000000000"
}
```

---

## 🔧 Input Variables

| Name                 | Type   | Description                                               | Required |
|----------------------|--------|-----------------------------------------------------------|----------|
| `scope`              | string | The scope at which the Role Assignment applies.           | ✅ Yes    |
| `role_definition_name` | string | The name of the Role Definition (e.g., `Reader`, `Contributor`). | ✅ Yes    |
| `principal_id`       | string | The object ID of the principal (user, group, or identity).| ✅ Yes    |

---

## 🛡️ Security & Compliance

- Always follow the principle of least privilege.
- Avoid assigning overly broad roles like `Owner` unless absolutely necessary.
- Track and audit role assignments using Azure Activity Logs.

---

## 📚 Resources

- [Terraform Azure Provider - Role Assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)
- [Azure RBAC Documentation](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
