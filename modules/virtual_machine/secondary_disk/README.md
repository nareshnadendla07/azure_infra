# 📦 Azure Virtual Machine Secondary Disk Module

This Terraform module provisions a managed data disk and attaches it to an existing Azure Virtual Machine. It supports full configuration for secure, encrypted, and policy-driven disk creation and attachment.

---

## 📁 Resources Created

- `azurerm_managed_disk` – Provisions a managed disk with customizable properties.
- `azurerm_virtual_machine_data_disk_attachment` – Attaches the disk to a VM.

---

## 🚀 Usage

```hcl
module "vm_data_disk" {
  source                        = "./modules/vm_secondary_disk"
  disk_name                     = "datadisk01"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = "Premium_LRS"
  create_option                 = "Empty"
  disk_size_gb                  = 256
  disk_access_id                = var.disk_access_id
  network_access_policy         = "AllowAll"
  public_network_access_enabled = false
  disk_encryption_set_id        = var.disk_encryption_set_id

  virtual_machine_id            = azurerm_linux_virtual_machine.this.id
  lun                           = 1
  caching                       = "ReadWrite"
}
```

---

## 🔧 Input Variables

| Name                          | Type    | Description                                      | Required |
|-------------------------------|---------|--------------------------------------------------|----------|
| `disk_name`                   | string  | Name of the managed disk                         | ✅ Yes   |
| `location`                    | string  | Azure region                                     | ✅ Yes   |
| `resource_group_name`         | string  | Resource group name                              | ✅ Yes   |
| `storage_account_type`        | string  | Type of the storage account                      | ✅ Yes   |
| `create_option`               | string  | Creation option (e.g., `Empty`, `Import`)        | ✅ Yes   |
| `disk_size_gb`                | number  | Size of the disk in GB                           | ✅ Yes   |
| `disk_access_id`              | string  | Disk access resource ID                          | ✅ Yes   |
| `network_access_policy`       | string  | Network access policy (e.g., `AllowAll`)         | ✅ Yes   |
| `public_network_access_enabled` | bool | Allow public access to the disk                  | ✅ Yes   |
| `disk_encryption_set_id`      | string  | ID of the disk encryption set                    | ✅ Yes   |
| `virtual_machine_id`          | string  | ID of the VM to attach the disk to               | ✅ Yes   |
| `lun`                         | number  | Logical Unit Number for disk attachment          | ✅ Yes   |
| `caching`                     | string  | Caching mode (e.g., `None`, `ReadOnly`, `ReadWrite`) | ✅ Yes |

---

## ✅ Outputs

| Name          | Description                  |
|---------------|------------------------------|
| `disk_id`     | ID of the created data disk  |

---

## 🛡️ Security & Compliance

- 💾 Disk encryption supported via Disk Encryption Set (DES)
- 🔐 Configurable access and network policies
- 🚫 Public access can be disabled for compliance

---

## 📚 Resources

- [Terraform azurerm_managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk)
- [Terraform azurerm_virtual_machine_data_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!