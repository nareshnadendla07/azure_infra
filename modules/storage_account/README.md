
# 🚀 Azure Storage Account Terraform Module

This Terraform module provisions a fully configurable Azure Storage Account with optional sub-resources like blobs, queues, tables, file shares, diagnostic settings, and customer-managed keys.

---

## 📦 Features

- Create Storage Account with optional blob properties
- Enable customer-managed keys (CMK) via Key Vault
- Configure containers, blobs, tables, queues, file shares using sub-modules
- Lifecycle and diagnostic settings included
- Supports modular policy management and monitoring

---

## 📁 Module Structure

```hcl
module "storage_account" {
  source = "./modules/storage_account"

  # Core storage account configuration
  storage_account_name       = "examplestorageacct"
  resource_group_name        = "rg-storage"
  location                   = "East US"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  account_kind               = "StorageV2"
  public_network_access_enabled = true

  # CMK settings
  identity_ids               = [azurerm_user_assigned_identity.example.id]
  identity_id                = azurerm_user_assigned_identity.example.id
  key_vault_id               = azurerm_key_vault.example.id
  key_vault_key_name         = "cmk-key-name"

  # Optional features
  include_containers         = true
  include_blobs              = true
  include_tables             = false
  include_queues             = false
  include_file_shares        = true

  # Submodule inputs
  containers                 = var.containers
  blob_name                  = "example.txt"
  blob_source                = "local/path/to/file.txt"
  blob_type                  = "Block"
  file_shares                = var.file_shares
  tables                     = var.tables
  queues                     = var.queues
  management_policies        = var.management_policies

  # Monitoring
  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = {
    environment = "dev"
    team        = "platform"
  }
}
```

---

## 🛠️ Requirements

- Terraform >= 1.3.0
- AzureRM Provider >= 3.0

---

## 🔧 Inputs

Refer to individual module `variables.tf` files for more details.

---

## 📤 Outputs

- `storage_account_id`
- `primary_blob_endpoint`
- `primary_file_endpoint`
- `container_names`
- `blob_name`
- `table_names`
- `queue_names`

---

## 🔐 Security & Compliance

- Supports customer-managed keys (CMK)
- Enables diagnostic settings for auditing read/write/delete activity
- Configurable public access & retention policies

---

## 📚 Resources

- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Storage Account Docs](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)

---

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!

---
