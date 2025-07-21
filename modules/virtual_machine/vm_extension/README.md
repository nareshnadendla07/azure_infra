
# Azure Virtual Machine Domain Join Extension

This Terraform module provisions the **Azure VM Extension** to join Windows Virtual Machines to an Active Directory Domain using the `JsonADDomainExtension`.

## 🚀 Resources Created

- `azurerm_virtual_machine_extension`

## 📥 Usage

```hcl
module "vm_domain_join" {
  source = "./modules/vm-domain-join"

  virtual_machines = {
    vm1 = {
      vm_id = azurerm_windows_virtual_machine.vm1.id
    }
  }
  domain_name     = "example.com"
  ou_path         = "OU=MyOU,DC=example,DC=com"
  domain_user     = "EXAMPLE\\domainjoinuser"
  domain_password = "SensitivePassword123!"  # Use secrets management in practice
}
```

## 🔧 Input Variables

| Name              | Type   | Description                                |
|-------------------|--------|--------------------------------------------|
| virtual_machines  | map    | Map of VM keys and their `vm_id` values    |
| domain_name       | string | Active Directory domain name               |
| ou_path           | string | Organizational Unit (OU) path              |
| domain_user       | string | Username used to join the domain           |
| domain_password   | string | Password for the domain user               |

## 🔐 Security Best Practices

- Use **Key Vault or secret manager** for `domain_password`
- Avoid hardcoding sensitive values in Terraform configuration


## 📚 Resources

- [Azure VM Extension: JsonADDomainExtension](https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/domain-join-windows)


## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!