####################
# Local declarations
####################

locals {
  resource_group_name = try(data.azurerm_resource_group.rgrp[0].name, azurerm_resource_group.rg[0].name)
  location            = try(data.azurerm_resource_group.rgrp[0].location, azurerm_resource_group.rg[0].location)
  if_ddos_enabled     = var.create_ddos_plan ? [{}] : []
}


data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

################
# Resource Group
################

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = merge({ "Name" = format("%s", var.resource_group_name) }, var.tags, )
}

###############
# VNET Creation
###############

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = local.location
  resource_group_name = local.resource_group_name
  dns_servers         = var.dns_servers
  address_space       = var.address_prefixes
  tags                = merge({ "Name" = format("%s", var.vnet_name) }, var.tags)

  dynamic "ddos_protection_plan" {
    for_each = local.if_ddos_enabled
    content {
      id     = azurerm_network_ddos_protection_plan.ddos[0].id
      enable = true
    }
  }
}

######################
# DDoS Protection Plan
######################

resource "azurerm_network_ddos_protection_plan" "ddos" {
  count               = var.create_ddos_plan ? 1 : 0
  name                = var.ddos_plan_name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = merge({ "Name" = format("%s", var.ddos_plan_name) }, var.tags)
}

#################
# Network Watcher
#################

resource "azurerm_resource_group" "nwatcher" {
  count    = var.create_network_watcher ? 1 : 0
  name     = "custom-nwatcher-rg-${var.location}"
  location = local.location
  tags     = merge({ "Name" = "custom-nwatcher-rg" }, var.tags)
}

locals {
  nwatcher_rg_name = try(azurerm_resource_group.nwatcher[0].name, "NetworkWatcherRG")
}

resource "azurerm_network_watcher" "nwatcher" {
  count               = var.create_network_watcher ? 1 : 0
  name                = "custom-nwatcher-${var.location}"
  location            = var.location
  resource_group_name = local.nwatcher_rg_name
  tags                = merge({ "Name" = format("custom-nwatcher-%s", var.location) }, var.tags)
}

########
# Subnet
########

module "subnet" {
  source               = "../subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = local.resource_group_name
  subnets              = var.subnets
  depends_on           = [azurerm_virtual_network.vnet]

}

#####################
## Diagnostic Setting
#####################

resource "azurerm_monitor_diagnostic_setting" "vnet_diagnostics" {
  name               = "${var.vnet_name}-diag"
  target_resource_id = azurerm_virtual_network.vnet.id

  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id = var.storage_account_id

  enabled_log {
    category = "VMProtectionAlerts"    
  }
  enabled_metric {
    category = "AllMetrics"    
  }
}
