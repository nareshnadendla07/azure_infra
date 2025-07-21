###############################################
# # Azure Virtual Machine Secondary Disk Module
###############################################

resource "azurerm_managed_disk" "this" {
  name                          = var.disk_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = var.storage_account_type
  create_option                 = var.create_option
  disk_size_gb                  = var.disk_size_gb
  disk_access_id                = var.disk_access_id
  network_access_policy         = var.network_access_policy
  public_network_access_enabled = var.public_network_access_enabled
  disk_encryption_set_id        = var.disk_encryption_set_id
}

#########################################
## Attach Managed Disk to Virtual Machine
#########################################

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  managed_disk_id    = azurerm_managed_disk.this.id
  virtual_machine_id = var.virtual_machine_id
  lun                = var.lun
  caching            = var.caching
}
