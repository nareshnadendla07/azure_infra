locals {
  if_threat_detection_policy_enabled = var.enable_threat_detection_policy ? [{}] : []
  #if_extended_auditing_policy_enabled = var.enable_extended_auditing_policy ? [{}] : []
  if_long_term_retention_policy_enabled = var.enable_long_term_retention_policy ? [1] : []
}

############################
# Azure SQL Server - Primary
############################
resource "azurerm_mssql_server" "primary" {
  name                         = format("%s-primary", var.sqlserver_name)
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = var.minimum_tls_version
  tags                         = merge({ "Name" = format("%s-primary", var.sqlserver_name) }, var.tags)

  dynamic "identity" {
    for_each = var.identity == true ? [1] : [0]
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  primary_user_assigned_identity_id            = var.primary_user_assigned_identity_id != "" ? var.primary_user_assigned_identity_id : null
  transparent_data_encryption_key_vault_key_id = var.transparent_data_encryption_key_vault_key_id

}

##############################
# Azure SQL Server - Secondary
##############################

resource "azurerm_mssql_server" "secondary" {
  count                        = var.enable_failover_group ? 1 : 0
  name                         = format("%s-secondary", var.sqlserver_name)
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = var.minimum_tls_version
  tags                         = merge({ "Name" = format("%s-secondary", var.sqlserver_name) }, var.tags)

  dynamic "identity" {
    for_each = var.identity == true ? [1] : [0]
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  primary_user_assigned_identity_id            = var.primary_user_assigned_identity_id != "" ? var.primary_user_assigned_identity_id : null
  transparent_data_encryption_key_vault_key_id = var.transparent_data_encryption_key_vault_key_id
}



###########################################
# Azure SQL Server Extended Auditing Policy
###########################################

resource "azurerm_mssql_server_extended_auditing_policy" "primary" {
  count                                   = var.enable_sql_server_extended_auditing_policy ? 1 : 0
  server_id                               = azurerm_mssql_server.primary.id
  storage_endpoint                        = var.storage_endpoint           #azurerm_storage_account.storeacc.0.primary_blob_endpoint
  storage_account_access_key              = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.log_retention_days
  log_monitoring_enabled                  = var.enable_log_monitoring == true && var.log_analytics_workspace_id != null ? true : false
}

#######################################################################
# SQL Database creation - Default edition:"Standard" and objective:"S1"
#######################################################################

resource "azurerm_mssql_database" "db" {
  name      = var.database_name
  server_id = azurerm_mssql_server.primary.id
  tags      = merge({ "Name" = format("%s-primary", var.database_name) }, var.tags, )

  dynamic "threat_detection_policy" {
    for_each = local.if_threat_detection_policy_enabled
    content {
      state                      = "Enabled"
      storage_endpoint           = var.storage_endpoint           #azurerm_storage_account.storeacc.0.primary_blob_endpoint
      storage_account_access_key = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key
      retention_days             = var.log_retention_days
      email_addresses            = var.email_addresses_for_alerts
    }
  }
  short_term_retention_policy {
    retention_days           = var.retention_days
    backup_interval_in_hours = var.backup_interval_in_hours
  }
  long_term_retention_policy {
    weekly_retention  = var.weekly_retention
    monthly_retention = var.monthly_retention
    yearly_retention  = var.yearly_retention
    week_of_year      = var.week_of_year

  }

  depends_on = [ azurerm_mssql_server.primary ]

}

##############################################
# Azure SQL Database - Threat Detection Policy
##############################################

resource "azurerm_mssql_database_threat_detection_policy" "tdp_primary" {
  count                      = var.enable_threat_detection_policy ? 1 : 0
  database_id                = azurerm_mssql_database.db.id
  state                      = "Enabled"
  storage_endpoint           = var.storage_endpoint           #azurerm_storage_account.storeacc.0.primary_blob_endpoint
  storage_account_access_key = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key
  retention_days             = var.log_retention_days
  email_addresses            = var.email_addresses_for_alerts

}

##############################################
# Azure SQL Database - Vulnerability Assessment
##############################################
resource "azurerm_mssql_database_vulnerability_assessment" "va_primary" {
  count                           = var.enable_vulnerability_assessment ? 1 : 0
  database_id                     = azurerm_mssql_database.db.id
  storage_container_path          = var.storage_container_path     #"${azurerm_storage_account.storeacc.0.primary_blob_endpoint}${azurerm_storage_container.storcont.0.name}/"
  storage_account_access_key      = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key

  dynamic "recurring_scans" {
    for_each = var.enable_vulnerability_assessment ? [1] : []
    content {
      enabled                   = true
      email_subscription_admins = true
      emails                    = var.email_addresses_for_alerts
    }
  }
}

#################################################
# Azure SQL Database - Long Term Retention Policy
#################################################

resource "azurerm_mssql_database_long_term_retention_policy" "ltr_primary" {
  count               = var.enable_long_term_retention_policy ? 1 : 0
  database_id         = azurerm_mssql_database.db.id
  weekly_retention    = var.weekly_retention
  monthly_retention   = var.monthly_retention
  yearly_retention    = var.yearly_retention
  week_of_year        = var.week_of_year
  storage_account_id  = var.storage_account_id != null ? var.storage_account_id : null

}

###############################################
# Azure SQL Database - Extended Auditing Policy
###############################################

resource "azurerm_mssql_database_extended_auditing_policy" "primary" {
  count                                   = var.enable_database_extended_auditing_policy ? 1 : 0
  database_id                             = azurerm_mssql_database.db.id
  storage_endpoint                        = var.storage_endpoint           #azurerm_storage_account.storeacc.0.primary_blob_endpoint
  storage_account_access_key              = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.log_retention_days
  log_monitoring_enabled                  = var.enable_log_monitoring == true && var.log_analytics_workspace_id != null ? true : null
}


#######################################################
# SQL Server Security Alert Policy - Default is "false"
#######################################################

resource "azurerm_mssql_server_security_alert_policy" "sap_primary" {
  count                      = var.enable_vulnerability_assessment ? 1 : 0
  resource_group_name        = var.resource_group_name
  server_name                = azurerm_mssql_server.primary.name
  state                      = "Enabled"
  email_account_admins       = true
  email_addresses            = var.email_addresses_for_alerts
  retention_days             = var.threat_detection_audit_logs_retention_days
  disabled_alerts            = var.disabled_alerts
  storage_account_access_key = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key
  storage_endpoint           = var.storage_endpoint           #azurerm_storage_account.storeacc.0.primary_blob_endpoint
}

##################################################################################
# SQL ServerVulnerability assessment and alert to admin team  - Default is "false"
##################################################################################

resource "azurerm_mssql_server_vulnerability_assessment" "va_primary" {
  count                           = var.enable_vulnerability_assessment ? 1 : 0
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.sap_primary.0.id
  storage_container_path          = var.storage_container_path     #"${azurerm_storage_account.storeacc.0.primary_blob_endpoint}${azurerm_storage_container.storcont.0.name}/"
  storage_account_access_key      = var.storage_account_access_key #azurerm_storage_account.storeacc.0.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails                    = var.email_addresses_for_alerts
  }
}

#################################################################################################
# Create and initialize a Microsoft SQL Server database using sqlcmd utility - Default is "false"
#################################################################################################

resource "null_resource" "create_sql" {
  count = var.initialize_sql_script_execution ? 1 : 0
  provisioner "local-exec" {
    command = "sqlcmd -I -U ${azurerm_mssql_server.primary.administrator_login} -P ${azurerm_mssql_server.primary.administrator_login_password} -S ${azurerm_mssql_server.primary.fully_qualified_domain_name} -d ${azurerm_mssql_database.db.name} -i ${var.sqldb_init_script_file} -o ${format("%s.log", replace(var.sqldb_init_script_file, "/.sql/", ""))}"
  }
}

######################################################
# Azure SQL Server Firewall Rules - Default is "false"
######################################################

resource "azurerm_mssql_firewall_rule" "fw01" {
  count = var.enable_firewall_rules && length(var.firewall_rules) > 0 ? length(var.firewall_rules) : 0
  name  = element(var.firewall_rules, count.index).name

  server_id        = azurerm_mssql_server.primary.id
  start_ip_address = element(var.firewall_rules, count.index).start_ip_address
  end_ip_address   = element(var.firewall_rules, count.index).end_ip_address
}


##################################################
# Key Vault Access Policy for MSSQL Encryption Set
##################################################

resource "azurerm_key_vault_access_policy" "mssql_encryption" {
  key_vault_id = var.key_vault_id                  
  tenant_id    = var.mssql_encryption_tenant_id   
  object_id    = var.mssql_encryption_principal_id

  key_permissions = ["Get", "List" ,"WrapKey", "UnwrapKey"]

}

# resource "azurerm_sql_firewall_rule" "fw02" {
#   count               = var.enable_failover_group && var.enable_firewall_rules && length(var.firewall_rules) > 0 ? length(var.firewall_rules) : 0
#   name                = element(var.firewall_rules, count.index).name
#   resource_group_name = var.resource_group_name
#   server_name         = azurerm_mssql_server.secondary.0.name
#   start_ip_address    = element(var.firewall_rules, count.index).start_ip_address
#   end_ip_address      = element(var.firewall_rules, count.index).end_ip_address
# }

#---------------------------------------------------------
# Azure SQL Failover Group - Default is "false" 
#---------------------------------------------------------

# resource "azurerm_mssql_failover_group" "fog" {
#   count               = var.enable_failover_group ? 1 : 0
#   name                = "sqldb-failover-group"
# #   resource_group_name = var.resource_group_name
# #   server_name         = azurerm_mssql_server.primary.name
#   server_id           = azureem_sql_server.primary.id
#   databases           = [azurerm_mssql_database.db.id]
#   tags                = merge({ "Name" = format("%s", "sqldb-failover-group") }, var.tags, )

#   partner_server {
#     id = azurerm_mssql_server.secondary.0.id
#   }

#   read_write_endpoint_failover_policy {
#     mode          = "Automatic"
#     grace_minutes = 60
#   }


# }

#################################################
# Azure SQL Database - Monitoring and Diagnostics
#################################################

resource "azurerm_monitor_diagnostic_setting" "extaudit" {
  count                      = var.enable_log_monitoring == true && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = lower("${var.database_name}-diag")
  target_resource_id         = azurerm_mssql_database.db.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id != null ? var.storage_account_id : null

  #   dynamic "log" {
  #     for_each = var.extaudit_diag_logs
  #     content {
  #       category = log.value
  #       enabled  = true
  #       retention_policy {
  #         enabled = false
  #       }
  #     }
  #   }

  enabled_metric {
    category = "AllMetrics"
  }

}
