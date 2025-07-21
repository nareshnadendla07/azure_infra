# 🔐 Azure Disk Encryption Set with Key Vault Access

This Terraform module provisions an Azure Disk Encryption Set (DES) and configures it to use a customer-managed key stored in Azure Key Vault. It also ensures that all necessary permissions and role assignments are handled securely and with best practices.

---

## 📦 Resources Created

- `azurerm_disk_encryption_set`
- `azurerm_key_vault_access_policy`
- `azurerm_role_assignment`

---

## ✅ Usage Example

```hcl
module "disk_encryption_set" {
  source = "./modules/disk-encryption"

  disk_encryption_set_name     = "myDes"
  location                     = "East US"
  resource_group_name          = "myResourceGroup"
  key_vault_key_id             = azurerm_key_vault_key.example.id
  key_vault_id                 = azurerm_key_vault.example.id
  auto_key_rotation_enabled    = true
  tags                         = {
    Environment = "Production"
  }
}
```

---

## 🔐 Key Vault Access Policy - Best Practices

The following minimal permissions are required for encrypting disks:

```hcl
key_permissions = [
  "Get",
  "WrapKey",
  "UnwrapKey"
]
```

This ensures the Disk Encryption Set can access and use the key for encrypting and decrypting disks without over-permissioning.

> 🔒 Do not include `Delete`, `Create`, or `Update` permissions unless absolutely necessary.

---

## 📤 Outputs

No direct outputs. Add output values if you wish to expose the DES ID or principal ID for downstream resources.

---

## 🛡️ Security & Compliance

- Uses **SystemAssigned** identity for secure, isolated access.
- Follows **least privilege principle** with minimal Key Vault permissions.
- Ensures access policy is applied **before** DES creation to avoid dependency issues.
- Scoped Role Assignment with **"Disk Encryption Set Contributor"** role only.

---

## 📚 Resources

- [Azure Disk Encryption Set Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/disk-encryption)
- [Terraform azurerm_disk_encryption_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set)
- [Azure Key Vault Permissions](https://learn.microsoft.com/en-us/azure/key-vault/general/overview-security)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!

