# ☁️ Azure Linux Virtual Machine Module

This Terraform module deploys a secure and configurable Linux Virtual Machine (VM) on Azure. It supports SSH key generation, managed identities, availability zones, and more. Ideal for Dev environments.

---

## 📦 Resources Created

- `azurerm_linux_virtual_machine`
- `tls_private_key` (optional SSH key pair)
- VM components such as:
  - OS Disk
  - Managed Identity
  - Boot Diagnostics
  - Proximity Placement Group
  - Availability Set

---

## 🔧 Usage

```hcl
module "linux_vm" {
  source = "./modules/linux_vm"

  os_flavor                        = "linux"
  instances_count                 = 1
  virtual_machine_name            = "dev-linux-vm"
  location                        = "East US"
  resource_group_name             = "rg-dev"
  virtual_machine_size            = "Standard_DS2_v2"
  admin_username                  = "azureuser"
  admin_password                  = "P@ssw0rd123!"

  disable_password_authentication = true
  generate_admin_ssh_key          = true

  network_interface_id            = azurerm_network_interface.nic.id

  image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk = {
    name                   = "dev-osdisk"
    caching                = "ReadWrite"
    disk_size_gb           = 64
    disk_encryption_set_id = null
  }

  enable_boot_diagnostics = true
  boot_diagnostics_storage_uri = "https://yourstorageaccount.blob.core.windows.net/"

  tags = {
    environment = "dev"
  }
}
```

---

## 🔐 SSH Key

If `generate_admin_ssh_key = true`, a 4096-bit RSA key is generated using the `tls_private_key` resource.

---

## ⚙️ Advanced Options

- `availability_set_id`
- `proximity_placement_group_id`
- `source_image_id`
- `dedicated_host_id`
- `custom_data` for cloud-init

---

## 🛡️ Security & Compliance

- Supports disk encryption via customer-managed key
- Can assign system/user managed identities
- Enable/disable password authentication

---

## 📚 Resources

- [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)
- [tls_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!