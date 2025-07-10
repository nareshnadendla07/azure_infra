resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge({ "Name" = format("%s", var.nsg_name) }, var.tags)

  dynamic "security_rule" {
    for_each = var.rules
    content {
      name                       = security_rule.value.name
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
    }
  }
}

#################
# NSG Association 
#################

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


################################
# azurerm monitoring diagnostics 
################################

resource "azurerm_monitor_diagnostic_setting" "nsg_diagnostic" {
  count = length(trimspace(var.log_analytics_workspace_id)) > 0 ? 1 : 0
  name                       = lower("${var.nsg_name}-diag")
  target_resource_id         = azurerm_network_security_group.nsg.id
  storage_account_id         = var.storage_account_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "Network"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "GroupRule"
  }

  enabled_log {
    category = "FlowEvent"
  }

  enabled_metric {
    category = "AllMetrics"
    
  }

  depends_on = [azurerm_network_security_group.nsg]
}
