resource "azurerm_cognitive_account" "this" {
  name                = var.cognitive_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = var.kind
  sku_name = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  custom_subdomain_name = var.custom_subdomain_name

  identity {
    type = "SystemAssigned"
  }

  network_acls {
    default_action = var.default_action
    
  }

  tags = var.tags
}


#####################
## Diagnostic Setting
#####################

resource "azurerm_monitor_diagnostic_setting" "ag_diagnostics" {
  name                       = "${var.cognitive_name}-diag"
  target_resource_id         = azurerm_virtual_desktop_application_group.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id

  enabled_log {
    category = "AuditLogs"
  }

  enabled_log {
    category = "RequestandResponseLogs"
  }

  enabled_log {
    category = "AzureOpenAIRequestUsage"
  }

  enabled_log {
    category = "TraceLogs"
  }

  enabled_metric {
    category = "AllMetrics"        
  }
}

########################################
## Role Assignment for Cognitive Account
########################################

resource "azurerm_role_assignment" "cognitive_account_role_assignment" {
  scope                = azurerm_cognitive_account.this.id
  role_definition_name = "Cognitive Services Account Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}