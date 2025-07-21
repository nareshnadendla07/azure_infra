# Output the ID of the Key Vault
output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.main.id
}

# Output the URI of the Key Vault
output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

# Output the Key Vault Access Policies
output "key_vault_access_policies" {
  description = "The Access Policies configured for the Key Vault"
  value       = azurerm_key_vault.main.access_policy
}

# Output the Diagnostic Settings for Key Vault
# output "key_vault_diagnostic_setting_id" {
#   description = "The ID of the diagnostic setting for the Key Vault"
#   value       = length(azurerm_monitor_diagnostic_setting.kv_diagnostics) > 0 ? azurerm_monitor_diagnostic_setting.kv_diagnostics[0].id : null
#   sensitive   = false
# }

# Output the Azure AD Group Object IDs
output "azure_ad_group_object_ids" {
  description = "Object IDs of the Azure AD groups"
  value       = local.group_object_ids
}

# Output the Azure AD User Object IDs
output "azure_ad_user_object_ids" {
  description = "Object IDs of the Azure AD users"
  value       = local.user_object_ids
}

# Output the Azure AD Service Principal Object IDs
output "azure_ad_service_principal_object_ids" {
  description = "Object IDs of the Azure AD service principals"
  value       = local.spn_object_ids
}

# Output the Diagnostic Log Categories Enabled
output "key_vault_diagnostic_log_categories" {
  description = "Diagnostic log categories enabled for the Key Vault"
  value       = var.kv_diag_logs
}

# Output the Log Analytics Workspace ID (if configured)
output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = var.log_analytics_workspace_id
}


output "key_vault_key_id" {
  description = "The ID of the Key Vault Key"
  #value       = regexreplace(azurerm_key_vault_key.disk_encryption_key.id, "/[^/]+$", "")  #regex("[^/]+$", "", azurerm_key_vault_key.disk_encryption_key.id)
  value       = substr(azurerm_key_vault_key.disk_encryption_key.id, 0, length(azurerm_key_vault_key.disk_encryption_key.id) - 33)
}

output "mssql_key_vault_key_id" {
  description = "The ID of the Key Vault Key"  
  value       = azurerm_key_vault_key.mssql_encryption_key.id #substr(azurerm_key_vault_key.mssql_encryption_key.id, 0, length(azurerm_key_vault_key.mssql_encryption_key.id) - 33)
}

output "storage_key_vault_key_id" {
  description = "The versionless ID of the Key Vault Key"
  value       = substr(azurerm_key_vault_key.storage_encryption_key.id, 0, length(azurerm_key_vault_key.storage_encryption_key.id) - 33)
}


output "storage_key_vault_key_name" {
  description = "The ID of the Key Vault Key"
  value       = azurerm_key_vault_key.storage_encryption_key.name
}