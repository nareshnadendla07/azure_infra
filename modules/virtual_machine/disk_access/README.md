# ☁️ Azure Disk Access Module

This Terraform module creates an Azure Disk Access resource, which allows private endpoint access to Azure disks.

## 📦 Resources

- `azurerm_disk_access`

## 📄 Example Usage

```hcl
module "disk_access" {
  source              = "./disk_access"
  disk_access_name    = "example-disk-access"
  resource_group_name = "example-rg"
  location            = "East US"
  tags = {
    environment = "dev"
  }
}
```

## 🔧 Input Variables

| Name                 | Type   | Description                              | Required |
|----------------------|--------|------------------------------------------|----------|
| `disk_access_name`   | string | Name of the Disk Access resource         | ✅       |
| `resource_group_name`| string | Name of the resource group               | ✅       |
| `location`           | string | Azure location for the resource          | ✅       |
| `tags`               | map    | Optional tags for the resource           | ❌       |

## 📤 Outputs

| Name             | Description                        |
|------------------|------------------------------------|
| `id`             | The ID of the Disk Access resource |

## 🛡️ Security & Compliance

Ensure network access is controlled via Private Endpoints and appropriate NSGs.

## 📚 Resources

- [Terraform Registry - azurerm_disk_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_access)
- [Microsoft Docs - Azure Disk Access](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-private-links)

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!