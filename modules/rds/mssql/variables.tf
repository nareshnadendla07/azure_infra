variable "location" {
  description = "Location for all resources."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "enable_sql_server_extended_auditing_policy" {
  description = "Manages Extended Audit policy for SQL servers"
  default     = true
}

variable "enable_database_extended_auditing_policy" {
  description = "Manages Extended Audit policy for SQL database"
  default     = false
}

variable "enable_threat_detection_policy" {
  description = ""
  default     = false
}

variable "sqlserver_name" {
  description = "SQL server Name"
  type        = string
}

variable "sql_version" {
  description = "SQL version"
  type        = string

}
variable "admin_username" {
  description = "The administrator login name for the new SQL Server"
  type        = string
}

variable "admin_password" {
  description = "The password associated with the admin_username user"
  type        = string
}

variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "sql_database_edition" {
  description = "The edition of the database to be created"
  type        = string
}

variable "sqldb_service_objective_name" {
  description = " The service objective name for the database"
  type        = string
}

variable "log_retention_days" {
  description = "Specifies the number of days to keep in the Threat Detection audit logs"
  type        = string
}

variable "threat_detection_audit_logs_retention_days" {
  description = "Specifies the number of days to keep in the Threat Detection audit logs."
  default     = 0
}

variable "enable_vulnerability_assessment" {
  description = "Manages the Vulnerability Assessment for a MS SQL Server"
  default     = false
}

variable "email_addresses_for_alerts" {
  description = "A list of email addresses which alerts should be sent to."
  type        = list(any)
  default     = []
}

variable "disabled_alerts" {
  description = "Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action."
  type        = list(any)
  default     = []
}

variable "ad_admin_login_name" {
  description = "The login name of the principal to set as the server administrator"
  default     = null
}

variable "identity" {
  description = "If you want your SQL Server to have an managed identity. Defaults to false."
  default     = false
}

variable "enable_firewall_rules" {
  description = "Manage an Azure SQL Firewall Rule"
  default     = false
}

variable "enable_failover_group" {
  description = "Create a failover group of databases on a collection of Azure SQL servers"
  default     = false
}

variable "secondary_sql_server_location" {
  description = "Specifies the supported Azure location to create secondary sql server resource"
  default     = "northeurope"
}

variable "enable_private_endpoint" {
  description = "Manages a Private Endpoint to SQL database"
  default     = false
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = ""
}

variable "private_subnet_address_prefix" {
  description = "The name of the subnet for private endpoints"
  default     = null
}

variable "existing_vnet_id" {
  description = "The resoruce id of existing Virtual network"
  default     = null
}

variable "existing_subnet_id" {
  description = "The resource id of existing subnet"
  default     = null
}

variable "existing_private_dns_zone" {
  description = "Name of the existing private DNS zone"
  default     = null
}

variable "firewall_rules" {
  description = "Range of IP addresses to allow firewall connections."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

variable "enable_log_monitoring" {
  description = "Enable audit events to Azure Monitor?"
  default     = false
}

variable "initialize_sql_script_execution" {
  description = "Allow/deny to Create and initialize a Microsoft SQL Server database"
  default     = false
}

variable "sqldb_init_script_file" {
  description = "SQL Script file name to create and initialize the database"
  default     = ""
}

variable "log_analytics_workspace_id" {
  description = "Specifies the ID of a Log Analytics Workspace where Diagnostics Data to be sent"
  default     = null
}

variable "storage_account_id" {
  description = "The name of the storage account to store the all monitoring logs"
  default     = null
}

variable "extaudit_diag_logs" {
  description = "Database Monitoring Category details for Azure Diagnostic setting"
  default     = ["SQLSecurityAuditEvents", "SQLInsights", "AutomaticTuning", "QueryStoreRuntimeStatistics", "QueryStoreWaitStatistics", "Errors", "DatabaseWaitStatistics", "Timeouts", "Blocks", "Deadlocks"]
}

variable "storage_account_access_key" {
  description = "Primary access key for the storage account."
  type        = string
}

variable "storage_endpoint" {
  description = "Primary blob endpoint for the storage account."
  type        = string
}

variable "storage_container_path" {
  description = "Primary container path for the storage account."
  type        = string

}

variable "tags" {
  description = "Tags of the resource."
  type        = map(string)
  default     = {}
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the disk encryption key is stored"
  type        = string
}

variable "transparent_data_encryption_key_vault_key_id" {
  description = "The ID of the Key Vault where the disk encryption key is stored"
  type        = string
}

variable "mssql_encryption_tenant_id" {
  description = "The tenant ID for the MSSQL encryption."
  type        = string
}

variable "mssql_encryption_principal_id" {
  description = "The principal ID for the MSSQL encryption."
  type        = string
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

variable "minimum_tls_version" {
  description = "The minimum TLS version."
  type        = string
}

variable "primary_user_assigned_identity_id" {
  description = "The ID of the primary user-assigned identity."
  type        = string
}

variable "enable_long_term_retention_policy" {
  type    = bool
  default = false
}

variable "weekly_retention" {
  type    = string
  default = "P520W" # 520 weeks = 10 years
}

variable "monthly_retention" {
  type    = string
  default = "P120M" # 120 months = 10 years
}

variable "yearly_retention" {
  type    = string
  default = "P10Y" # 10 years
}

variable "week_of_year" {
  type    = string
  default = "5"

}

variable "backup_interval_in_hours" {
  type    = string
  default = "24"

}

variable "retention_days" {
  type    = string
  default = "12"
}
