# 🪟 Azure Windows Virtual Machine Module

This Terraform module provisions an **Azure Windows Virtual Machine** with flexible configurations for enterprise-ready workloads, including support for:
- Availability sets, proximity placement groups, managed identities
- Spot instances, custom and marketplace images
- Optional WinRM listener and boot diagnostics
- Disk encryption and advanced patching options

---

## 🚀 Usage

```hcl
module "windows_vm" {
  source                        = "./windows_vm"
  os_flavor                     = "windows"
  instances_count               = 1
  virtual_machine_name          = "vm-windows"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  virtual_machine_size          = "Standard_DS2_v2"
  admin_username                = "azureadmin"
  admin_password                = var.admin_password
  disable_password_authentication = false
  use_spot_instance             = false

  network_interface_id          = azurerm_network_interface.nic.id

  os_disk = {
    name                    = "windows-osdisk"
    caching                 = "ReadWrite"
    disk_size_gb            = 128
    disk_encryption_set_id  = var.disk_encryption_set_id
  }

  windows_distribution_name     = "2019-Datacenter"
  windows_distribution_list     = var.windows_distribution_list

  managed_identity_type         = "SystemAssigned"
  tags                          = {
    environment = "dev"
    project     = "vm-deployment"
  }
}
```

---

## 📥 Input Variables

| Name                                           | Description                                                                  | Type     | Required |
|------------------------------------------------|------------------------------------------------------------------------------|----------|----------|
| `os_flavor`                                   | OS flavor (e.g., `windows`)                                                  | string   | ✅       |
| `instances_count`                             | Number of VM instances                                                       | number   | ✅       |
| `virtual_machine_name`                        | Base name for VM(s)                                                          | string   | ✅       |
| `location`                                    | Azure region                                                                 | string   | ✅       |
| `resource_group_name`                         | Name of the resource group                                                   | string   | ✅       |
| `virtual_machine_size`                        | VM size (e.g., `Standard_DS2_v2`)                                            | string   | ✅       |
| `admin_username`                              | Admin username                                                               | string   | ✅       |
| `admin_password`                              | Admin password                                                               | string   | ✅       |
| `os_disk`                                     | OS disk block with name, size, etc.                                          | object   | ✅       |
| `windows_distribution_name`                   | Key to pick a predefined image from the list                                 | string   | ✅       |
| `windows_distribution_list`                   | Map of image details                                                         | map      | ✅       |
| `network_interface_id`                        | ID of the NIC                                                                | string   | ✅       |
| `managed_identity_type`                       | `SystemAssigned`, `UserAssigned`, or both                                    | string   | ❌       |
| `managed_identity_ids`                        | List of user-assigned identity IDs                                           | list     | ❌       |
| `enable_boot_diagnostics`                     | Enable boot diagnostics                                                      | bool     | ❌       |
| `boot_diagnostics_storage_uri`                | URI of the storage account for diagnostics                                   | string   | ❌       |
| `enable_ultra_ssd_data_disk_storage_support`  | Enable Ultra SSD for data disks                                              | bool     | ❌       |
| `winrm_protocol`                              | `Http` or `Https`                                                            | string   | ❌       |
| `key_vault_certificate_secret_url`            | Secret URL for WinRM certificate                                             | string   | ❌       |
| `custom_image`                                | Custom image map with publisher, offer, sku, version                         | map      | ❌       |
| `source_image_id`                             | Full custom image ID if using an existing managed image                      | string   | ❌       |
| `tags`                                        | Tags to apply                                                                | map      | ❌       |

---

## 📤 Output

No output by default. Customize as needed.

---

## 🛡️ Security & Compliance

- Supports integration with Azure Disk Encryption Sets
- Password authentication can be disabled in favor of SSH or certificate-based access
- Supports boot diagnostics for post-deployment troubleshooting

---

## 📚 Resources

- [azurerm_windows_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine)
- [Azure Spot VMs](https://learn.microsoft.com/en-us/azure/virtual-machines/spot-vms)
- [Azure Managed Disks](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!