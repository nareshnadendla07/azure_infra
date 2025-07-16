resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku      = var.public_ip_sku_name
  sku_tier = var.public_ip_sku_tier

  allocation_method       = var.public_ip_allocation_method
  ip_version              = var.public_ip_address_version
  zones                   = var.zones
  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  tags = var.tags
  
}
