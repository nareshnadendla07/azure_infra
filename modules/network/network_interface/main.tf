####################
## Network Interface
####################

resource "azurerm_network_interface" "this" {
  name                           = var.nic_name
  location                       = var.location != "" ? var.location : var.resource_group_name.rg.location
  resource_group_name            = var.resource_group_name
  accelerated_networking_enabled = var.accelerated_networking_enabled
  tags                           = var.tags

  ip_configuration {
    name                          = var.nic_name
    primary                       = var.primary
    private_ip_address            = var.private_ip_address != "" ? var.private_ip_address : null
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation_method
    public_ip_address_id          = var.public_ip_address_id != "" ? var.public_ip_address_id : null

  }

  dns_servers = []
}

##################
## NIC Diagnostics
##################

resource "azurerm_monitor_diagnostic_setting" "nic_diagnostics" {
  name               = "${var.nic_name}-diag"
  target_resource_id = azurerm_network_interface.this.id

  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id


  enabled_metric {
    category = "AllMetrics"

  }
}
