##########################
# Azure Disk Access Module
##########################

resource "azurerm_disk_access" "example" {
  name                = var.disk_access_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags                = var.tags
}