#####################################################
# Data block to reference the existing Resource Group
#####################################################

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name #"ep-p-nae-avd-rg" 
}

data "azurerm_client_config" "current" {}

###################
## Create Public IP
###################

module "public_ip" {

  source = "../../modules/network/public-ip"

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  public_ip_name              = var.public_ip_name
  public_ip_allocation_method = var.public_ip_allocation_method
  zones                       = var.zones
  public_ip_address_version   = var.public_ip_address_version
  public_ip_sku_name          = var.public_ip_sku_name
  public_ip_sku_tier          = var.public_ip_sku_tier
  idle_timeout_in_minutes     = var.idle_timeout_in_minutes
 
  tags = var.tags

}
