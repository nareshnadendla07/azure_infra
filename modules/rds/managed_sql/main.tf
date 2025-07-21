locals {
  managed_identities = {
    system_assigned_user_assigned = (var.managed_identities.system_assigned || length(var.managed_identities.user_assigned_resource_ids) > 0) ? {
      this = {
        type                       = var.managed_identities.system_assigned && length(var.managed_identities.user_assigned_resource_ids) > 0 ? "SystemAssigned, UserAssigned" : length(var.managed_identities.user_assigned_resource_ids) > 0 ? "UserAssigned" : "SystemAssigned"
        user_assigned_resource_ids = var.managed_identities.user_assigned_resource_ids
      }
    } : {}
  }
  # Private endpoint application security group associations.
  # We merge the nested maps from private endpoints and application security group associations into a single map.
  private_endpoint_application_security_group_associations = { for assoc in flatten([
    for pe_k, pe_v in var.private_endpoints : [
      for asg_k, asg_v in pe_v.application_security_group_associations : {
        asg_key         = asg_k
        pe_key          = pe_k
        asg_resource_id = asg_v
      }
    ]
  ]) : "${assoc.pe_key}-${assoc.asg_key}" => assoc }
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
}

#############################
# Managed SQL Server Instance
#############################

resource "azurerm_mssql_managed_instance" "this" {

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  name                         = var.managed_instance_name

  resource_group_name = var.resource_group_name
  license_type        = var.license_type
  location            = var.location

  sku_name           = var.sku_name
  storage_size_in_gb = var.storage_size_in_gb
  subnet_id          = var.subnet_id
  vcores             = var.vcores

  collation                      = var.collation
  dns_zone_partner_id            = var.dns_zone_partner_id
  maintenance_configuration_name = var.maintenance_configuration_name
  minimum_tls_version            = var.minimum_tls_version
  proxy_override                 = var.proxy_override
  public_data_endpoint_enabled   = var.public_data_endpoint_enabled
  storage_account_type           = var.storage_account_type
  timezone_id                    = var.timezone_id
  zone_redundant_enabled         = var.zone_redundant_enabled



  dynamic "identity" {
    for_each = var.enable_identity ? [1] : []

    content {
      type = (
        var.system_assigned_identity && length(var.user_assigned_identity_ids) > 0 ? "SystemAssigned, UserAssigned" :
        var.system_assigned_identity ? "SystemAssigned" :
        length(var.user_assigned_identity_ids) > 0 ? "UserAssigned" :
        null
      )

      identity_ids = (
        length(var.user_assigned_identity_ids) > 0 ? var.user_assigned_identity_ids : null
      )
    }
  }


  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    ignore_changes = [
      identity
    ]
  }

  tags = merge({ "Name" = format("%s-primary", var.managed_instance_name) }, var.tags, )
}

############################################################
# Managed SQL Server Instance Active Directory Administrator
############################################################

resource "azurerm_mssql_managed_instance_active_directory_administrator" "this" {
  count = try(var.active_directory_administrator.object_id, null) == null ? 0 : 1

  login_username              = var.active_directory_administrator.login_username
  managed_instance_id         = azurerm_mssql_managed_instance.this.id
  object_id                   = var.active_directory_administrator.object_id
  tenant_id                   = var.active_directory_administrator.tenant_id
  azuread_authentication_only = var.active_directory_administrator.azuread_authentication_only

  dynamic "timeouts" {
    for_each = var.active_directory_administrator.timeouts == null ? [] : [var.active_directory_administrator.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

###################################################
# Managed SQL Server Instance Security Alert Policy
###################################################
resource "azurerm_mssql_managed_instance_security_alert_policy" "this" {
  count = var.security_alert_policy == null ? 0 : 1

  resource_group_name   = var.resource_group_name
  managed_instance_name = azurerm_mssql_managed_instance.this.name
  enabled               = var.security_alert_policy.enabled ? true : false
  email_addresses       = var.security_alert_policy.email_addresses
  retention_days        = var.security_alert_policy.retention_days

  dynamic "disabled_alerts" {
    for_each = var.security_alert_policy.disabled_alerts == null ? [] : [var.security_alert_policy.disabled_alerts]
    content {
      value = disabled_alerts.value
    }
  }

  dynamic "storage_account_access_key" {
    for_each = var.security_alert_policy.storage_account_access_key == null ? [] : [var.security_alert_policy.storage_account_access_key]
    content {
      value = storage_account_access_key.value
    }
  }

  dynamic "storage_endpoint" {
    for_each = var.security_alert_policy.storage_endpoint == null ? [] : [var.security_alert_policy.storage_endpoint]
    content {
      value = storage_endpoint.value
    }
  }

}
######################################################
# Managed SQL Server Instance Vulnerability Assessment
######################################################

resource "azurerm_mssql_managed_instance_vulnerability_assessment" "this" {
  managed_instance_id    = azurerm_mssql_managed_instance.this.id
  storage_container_path = var.storage_container_path #"${azurerm_storage_account.example.primary_blob_endpoint}${azurerm_storage_container.example.name}/"
  #storage_account_access_key = var.storage_account_access_key #azurerm_storage_account.example.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails                    = var.vulnerability_assessment_emails
  }

  depends_on = [azurerm_mssql_managed_instance_security_alert_policy.this]
}

##########################################################
# Azure API Resource Action for Managed SQL Server Instance
# Security Alert Policy 
##########################################################

resource "azapi_resource_action" "mssql_managed_instance_security_alert_policy" {
  count = var.security_alert_policy == {} ? 0 : 1

  resource_id = "${azurerm_mssql_managed_instance.this.id}/securityAlertPolicies/Default"
  type        = "Microsoft.Sql/managedInstances/securityAlertPolicies@2023-08-01-preview"
  body = {
    properties = {
      disabledAlerts          = try(var.security_alert_policy.disabled_alerts, [])
      emailAccountAdmins      = try(var.security_alert_policy.email_account_admins_enabled, false)
      emailAddresses          = try(var.security_alert_policy.email_addresses, [])
      retentionDays           = try(var.security_alert_policy.retention_days, 0)
      state                   = try(var.security_alert_policy.enabled ? "Enabled" : "Disabled", "Enabled")
      storageAccountAccessKey = try(var.security_alert_policy.storage_account_access_key, null)
      storageEndpoint         = try(var.security_alert_policy.storage_endpoint, null)
    }
  }
  method = "PUT"
}

#########################################################
# Managed SQL Server Instance Transparent Data Encryption
#########################################################

resource "azurerm_mssql_managed_instance_transparent_data_encryption" "this" {
  count = var.transparent_data_encryption == {} ? 0 : 1

  managed_instance_id   = azurerm_mssql_managed_instance.this.id
  auto_rotation_enabled = var.transparent_data_encryption.auto_rotation_enabled
  key_vault_key_id      = var.transparent_data_encryption.key_vault_key_id

  dynamic "timeouts" {
    for_each = var.transparent_data_encryption.timeouts == null ? [] : [var.transparent_data_encryption.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

######################################################
# Managed SQL Server Instance Vulnerability Assessment
######################################################

resource "azapi_resource_action" "mssql_managed_instance_vulnerability_assessment" {
  count = var.vulnerability_assessment == null ? 0 : 1

  resource_id = "${azurerm_mssql_managed_instance.this.id}/vulnerabilityAssessments/default"
  type        = "Microsoft.Sql/managedInstances/vulnerabilityAssessments@2023-08-01-preview"
  body = {
    properties = {
      storageAccountAccessKey = try(var.vulnerability_assessment.storage_account_access_key, null)
      storageContainerPath    = try(var.vulnerability_assessment.storage_container_path, null)
      storageContainerSasKey  = try(var.vulnerability_assessment.storage_container_sas_key, null)
      recurringScans = var.vulnerability_assessment.recurring_scans != {} ? {
        isEnabled               = try(var.vulnerability_assessment.recurring_scans.enabled, true)
        emailSubscriptionAdmins = try(var.vulnerability_assessment.recurring_scans.email_subscription_admins, true),
        emails                  = try(var.vulnerability_assessment.recurring_scans.emails, [])
      } : null
    }
  }
  method = "PUT"
}

##############################################
# Managed SQL Server Instance Role Assignments
##############################################
resource "azurerm_role_assignment" "sqlmi_system_assigned" {
  count = var.system_assigned_identity ? 1 : 0

  principal_id         = azurerm_mssql_managed_instance.this.identity[0].principal_id
  scope                = azurerm_mssql_managed_instance.this.id
  role_definition_name = "Managed Identity Operator"
}

# resource "azurerm_role_assignment" "sqlmi_system_assigned" {
#   count = var.storage_account_resource_id != null ? 1 : 0

#   principal_id         = var.principal_id
#   scope                = var.storage_account_resource_id
#   role_definition_name = "Storage Blob Data Contributor"
# }

##############################################
# Managed SQL Server Instance Management Lock
##############################################

resource "azurerm_management_lock" "this" {
  count = var.lock != null ? 1 : 0

  lock_level = var.lock.kind
  name       = coalesce(var.lock.name, "lock-${var.lock.kind}")
  scope      = azurerm_mssql_managed_instance.this.id
  notes      = var.lock.kind == "CanNotDelete" ? "Cannot delete the resource or its child resources." : "Cannot delete or modify the resource or its child resources."
}

##############################################
# Managed SQL Server Instance Role Assignments
##############################################

resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = azurerm_mssql_managed_instance.this.id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  role_definition_id                     = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_definition_id_or_name : null
  role_definition_name                   = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

##############################################################
# Azure API for Managed SQL Server Instance Managed Identities
##############################################################

resource "azapi_resource_action" "sql_managed_instance_patch_identities" {
  count = local.managed_identities.system_assigned_user_assigned == {} ? 0 : 1

  resource_id = azurerm_mssql_managed_instance.this.id
  type        = "Microsoft.Sql/managedInstances@2023-05-01-preview"
  body = {
    identity = {
      type = local.managed_identities.system_assigned_user_assigned.this.type
      userAssignedIdentities = {
        for id in tolist(local.managed_identities.system_assigned_user_assigned.this.user_assigned_resource_ids) : id => {}
      }
    },
    properties = {
      primaryUserAssignedIdentityId = length(local.managed_identities.system_assigned_user_assigned.this.user_assigned_resource_ids) > 0 ? tolist(local.managed_identities.system_assigned_user_assigned.this.user_assigned_resource_ids)[0] : null
    }
  }
  method = "PATCH"
}


data "azurerm_resource_group" "parent" {
  name = azurerm_mssql_managed_instance.this.resource_group_name
}

data "azapi_resource" "identity" {
  type                   = "Microsoft.Sql/managedInstances@2023-05-01-preview"
  name                   = azurerm_mssql_managed_instance.this.name
  parent_id              = data.azurerm_resource_group.parent.id
  response_export_values = ["identity"]

  depends_on = [azapi_resource_action.sql_managed_instance_patch_identities]
}

########################################################
# Managed SQL Server Instance Advanced Threat Protection
########################################################

resource "azurerm_mssql_managed_instance_advanced_threat_protection" "this" {
  managed_instance_id = azurerm_mssql_managed_instance.this.id
  state               = var.enable_advanced_threat_protection ? "Enabled" : "Disabled"

  dynamic "email_addresses" {
    for_each = var.advanced_threat_protection_email_addresses == null ? [] : [var.advanced_threat_protection_email_addresses]
    content {
      value = email_addresses.value
    }
  }

  dynamic "storage_endpoint" {
    for_each = var.advanced_threat_protection_storage_endpoint == null ? [] : [var.advanced_threat_protection_storage_endpoint]
    content {
      value = storage_endpoint.value
    }
  }

  dynamic "storage_account_access_key" {
    for_each = var.advanced_threat_protection_storage_account_access_key == null ? [] : [var.advanced_threat_protection_storage_account_access_key]
    content {
      value = storage_account_access_key.value
    }
  }
}
# resource "azapi_resource_action" "sql_advanced_threat_protection" {
#   resource_id = "${azurerm_mssql_managed_instance.this.id}/advancedThreatProtectionSettings/Default"
#   type        = "Microsoft.Sql/managedInstances/advancedThreatProtectionSettings@2023-08-01-preview"
#   body = {
#     properties = {
#       state = var.enable_advanced_threat_protection ? "Enabled" : "Disabled"
#     }
#   }
#   method = "PUT"
# }

########################################################
# Managed SQL Server Instance Diagnostic Settings
########################################################

resource "azurerm_monitor_diagnostic_setting" "mng_sql_diagnostics" {
  count                      = var.log_analytics_workspace_id != null ? 1 : 0
  name                       = lower("${var.managed_instance_name}-diag")
  target_resource_id         = azurerm_mssql_managed_instance.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id != null ? var.storage_account_id : null

  enabled_log {
    category = "SQLSecurityAuditEvents"
  }

  enabled_metric {
    category = "AllMetrics"
  }

}



