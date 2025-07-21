# ☁️ Azure Virtual Machine Module (Classic Resource)

This Terraform module provisions an **Azure Virtual Machine (azurerm_virtual_machine)** for both **Linux** and **Windows** operating systems. It supports SSH keys, WinRM configuration, OS/data disk management, and optional multiple data disks.

---

## 🚀 Features

- Supports both **Linux** and **Windows** OS profiles
- Dynamically configures `os_profile_linux_config` or `os_profile_windows_config`
- Configurable:
  - OS and data disks
  - WinRM listeners (for Windows)
  - SSH Keys (for Linux)
- Dynamically attaches multiple data disks
- Supports provisioning agent and updates

---

## 📦 Usage

```hcl
module "vm" {
  source              = "./vm_module"
  vm_name             = "myvm"
  location            = "East US"
  resource_group_name = "my-rg"
  vm_size             = "Standard_DS1_v2"
  os_type             = "Linux" # or "Windows"

  image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk = {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 64
  }

  data_disks = [
    {
      lun               = 0
      name              = "datadisk1"
      caching           = "ReadOnly"
      create_option     = "Empty"
      managed_disk_type = "Standard_LRS"
      disk_size_gb      = 128
    }
  ]

  vm_admin_username = "azureuser"
  vm_admin_password = "ComplexP@ssword123!"
  disable_password_authentication = false
  public_keys = [
    {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3Nza..."
    }
  ]

  win_rm = []

  network_interface_id = azurerm_network_interface.nic.id
  tags = {
    environment = "dev"
  }
}
```

---

## ⚙️ Inputs

| Name                        | Description                                     | Type    | Required |
|-----------------------------|-------------------------------------------------|---------|----------|
| `vm_name`                  | Virtual machine name                            | string  | ✅ Yes   |
| `location`                 | Azure location                                  | string  | ✅ Yes   |
| `resource_group_name`      | Name of the resource group                      | string  | ✅ Yes   |
| `vm_size`                  | Size of the VM                                  | string  | ✅ Yes   |
| `os_type`                  | "Linux" or "Windows"                            | string  | ✅ Yes   |
| `image_reference`          | Publisher, offer, sku, version                  | map     | ✅ Yes   |
| `os_disk`                  | OS disk configuration                          | map     | ✅ Yes   |
| `data_disks`               | Optional list of data disks                    | list    | ❌ No    |
| `vm_admin_username`        | VM admin username                              | string  | ✅ Yes   |
| `vm_admin_password`        | Admin password (for Windows)                   | string  | ✅ Yes   |
| `disable_password_authentication` | Disable password login (Linux)         | bool    | ❌ No    |
| `public_keys`              | SSH keys for Linux VMs                         | list    | ❌ No    |
| `win_rm`                   | WinRM settings for Windows                     | list    | ❌ No    |
| `network_interface_id`     | NIC to associate                               | string  | ✅ Yes   |
| `tags`                     | Resource tags                                   | map     | ❌ No    |

---

## 📤 Outputs

You can optionally expose:
- `vm_id`
- `vm_private_ip`
- `os_disk_id`

---

## 🛡️ Security & Compliance

- For production, enable boot diagnostics, disk encryption, and user-assigned identities.
- For Windows, use secrets for passwords and WinRM certificates.
- For Linux, prefer SSH over password-based auth.

---

## 📚 Resources

- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [azurerm_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine)
- [Azure VM Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!