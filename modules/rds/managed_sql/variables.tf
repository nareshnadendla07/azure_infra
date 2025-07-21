variable "managed_instance_name" {
  description = "The name of the Managed Instance."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the Managed Instance."
  type        = string
}

variable "sku_name" {
  description = "Managed instance SKU."
  type        = string
}

variable "vcores" {
  description = "The number of vCores."
  type        = number
}

variable "administrator_login" {
  description = "The login of the Managed Instance admin."
  type        = string
}

variable "administrator_login_password" {
  description = "The password of the Managed Instance admin."
  type        = string
}

variable "storage_size_in_gb" {
  description = "Storage size in GB for the instance."
  type        = number
}

variable "collation" {
  description = "Collation of the Managed Instance."
  type        = string
}

variable "timezone_id" {
  description = "Id of the timezone."
  type        = string
}

variable "public_data_endpoint_enabled" {
  description = "Enable public data endpoint."
  type        = bool
}

variable "license_type" {
  description = "Determines license pricing model."
  type        = string
}

variable "dns_zone_partner_id" {
  description = "The resource id of another Managed Instance whose DNS zone this Managed Instance will share."
  type        = string
}

variable "minimum_tls_version" {
  description = "The minimum TLS version enforced by the Managed Instance."
  type        = string
}

variable "storage_account_type" {
  description = "Option for configuring backup storage redundancy."
  type        = string
}

variable "zone_redundant_enabled" {
  description = "Determines whether zone redundancy will be enabled."
  type        = bool
}

variable "maintenance_configuration_name" {
  description = "Maintenance configuration id assigned to the database."
  type        = string
}

variable "tags" {
  description = "Tags of the resource."
  type        = map(string)
  default     = {}
}


variable "enable_identity" {
  description = "Whether to enable identity block"
  type        = bool
  default     = true
}

variable "system_assigned_identity" {
  description = "Enable system-assigned identity"
  type        = bool
  default     = false
}

variable "user_assigned_identity_ids" {
  description = "List of user-assigned identity resource IDs"
  type        = list(string)
  default     = []
}


variable "proxy_override" {
  type        = string
  default     = null
  description = "(Optional) Specifies how the SQL Managed Instance will be accessed. Default value is `Default`. Valid values include `Default`, `Proxy`, and `Redirect`."
}

variable "subnet_id" {
    description = "The ID of the subnet where the Managed Instance will be deployed."
    type        = string
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-DESCRIPTION
 - `create` - (Defaults to 24 hours) Used when creating the Microsoft SQL Managed Instance.
 - `delete` - (Defaults to 24 hours) Used when deleting the Microsoft SQL Managed Instance.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Microsoft SQL Managed Instance.
 - `update` - (Defaults to 24 hours) Used when updating the Microsoft SQL Managed Instance.
DESCRIPTION
}


variable "active_directory_administrator" {
  type = object({
    azuread_authentication_only = optional(bool)
    login_username              = optional(string)
    object_id                   = optional(string)
    tenant_id                   = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
  description = <<-DESCRIPTION
 - `azuread_authentication_only` - (Optional) When `true`, only permit logins from AAD users and administrators. When `false`, also allow local database users.
 - `login_username` - (Required) The login name of the principal to set as the Managed Instance Administrator.
 - `object_id` - (Required) The Object ID of the principal to set as the Managed Instance Administrator.
 - `tenant_id` - (Required) The Azure Active Directory Tenant ID.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the SQL Active Directory Administrator.
 - `delete` - (Defaults to 30 minutes) Used when deleting the SQL Active Directory Administrator.
 - `read` - (Defaults to 5 minutes) Used when retrieving the SQL Active Directory Administrator.
 - `update` - (Defaults to 30 minutes) Used when updating the SQL Active Directory Administrator.
DESCRIPTION
  default     = {}
  nullable    = false
}

variable "security_alert_policy" {
  type = object({
    disabled_alerts              = optional(set(string))
    email_account_admins_enabled = optional(bool)
    email_addresses              = optional(set(string))
    enabled                      = optional(bool)
    retention_days               = optional(number)
    storage_account_access_key   = optional(string)
    storage_endpoint             = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
  description = <<-DESCRIPTION
 - `disabled_alerts` - (Optional) Specifies an array of alerts that are disabled. Possible values are `Sql_Injection`, `Sql_Injection_Vulnerability`, `Access_Anomaly`, `Data_Exfiltration`, `Unsafe_Action` and `Brute_Force`.
 - `email_account_admins_enabled` - (Optional) Boolean flag which specifies if the alert is sent to the account administrators or not. Defaults to `false`.
 - `email_addresses` - (Optional) Specifies an array of email addresses to which the alert is sent.
 - `enabled` - (Optional) Specifies the state of the Security Alert Policy, whether it is enabled or disabled. Possible values are `true`, `false`.
 - `retention_days` - (Optional) Specifies the number of days to keep in the Threat Detection audit logs. Defaults to `0`.
 - `storage_account_access_key` - (Optional) Specifies the identifier key of the Threat Detection audit storage account. This is mandatory when you use `storage_endpoint` to specify a storage account blob endpoint.
 - `storage_endpoint` - (Optional) Specifies the blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the MS SQL Managed Instance Security Alert Policy.
 - `delete` - (Defaults to 30 minutes) Used when deleting the MS SQL Managed Instance Security Alert Policy.
 - `read` - (Defaults to 5 minutes) Used when retrieving the MS SQL Managed Instance Security Alert Policy.
 - `update` - (Defaults to 30 minutes) Used when updating the MS SQL Managed Instance Security Alert Policy.
DESCRIPTION
  default     = {}
  nullable    = false
}

variable "storage_account_resource_id" {
  type        = string
  default     = null
  description = <<-DESCRIPTION
(Optional) Storage Account to store vulnerability assessments.  

The System Assigned Managed Identity will be granted Storage Blob Data Contributor over this storage account.  

Note these limitations documented in Microsoft Learn - <https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-vulnerability-assessment-storage?view=azuresql#store-va-scan-results-for-azure-sql-managed-instance-in-a-storage-account-that-can-be-accessed-behind-a-firewall-or-vnet>

* User Assigned MIs are not supported
* The storage account firewall public network access must be allowed.  If "Enabled from selected virtual networks and IP addresses" is set (recommended), the SQL MI subnet ID must be added to the storage account firewall.

DESCRIPTION  
}

variable "transparent_data_encryption" {
  type = object({
    auto_rotation_enabled = optional(bool)
    key_vault_key_id      = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
  description = <<-DESCRIPTION
 - `auto_rotation_enabled` - (Optional) When enabled, the SQL Managed Instance will continuously check the key vault for any new versions of the key being used as the TDE protector. If a new version of the key is detected, the TDE protector on the SQL Managed Instance will be automatically rotated to the latest key version within 60 minutes.
 - `key_vault_key_id` - (Optional) To use customer managed keys from Azure Key Vault, provide the AKV Key ID. To use service managed keys, omit this field.
 
 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the MSSQL.
 - `delete` - (Defaults to 30 minutes) Used when deleting the MSSQL.
 - `read` - (Defaults to 5 minutes) Used when retrieving the MSSQL.
 - `update` - (Defaults to 30 minutes) Used when updating the MSSQL.
DESCRIPTION
  default     = {}
  nullable    = false
}

variable "vulnerability_assessment" {
  type = object({
    storage_account_access_key = optional(string)
    storage_container_path     = optional(string)
    storage_container_sas_key  = optional(string)
    recurring_scans = optional(object({
      email_subscription_admins = optional(bool)
      emails                    = optional(list(string))
      enabled                   = optional(bool)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
  description = <<-DESCRIPTION
 - `storage_account_access_key` - (Optional) Specifies the identifier key of the storage account for vulnerability assessment scan results. If `storage_container_sas_key` isn't specified, `storage_account_access_key` is required.  Set to `null` if the storage account is protected by a resource firewall.
 - `storage_container_path` - (Required) A blob storage container path to hold the scan results (e.g. <https://myStorage.blob.core.windows.net/VaScans/>).
 - `storage_container_sas_key` - (Optional) A shared access signature (SAS Key) that has write access to the blob container specified in `storage_container_path` parameter. If `storage_account_access_key` isn't specified, `storage_container_sas_key` is required.  Set to `null` if the storage account is protected by a resource firewall.

 ---
 `recurring_scans` block supports the following:
 - `email_subscription_admins` - (Optional) Boolean flag which specifies if the schedule scan notification will be sent to the subscription administrators. Defaults to `true`.
 - `emails` - (Optional) Specifies an array of e-mail addresses to which the scan notification is sent.
 - `enabled` - (Optional) Boolean flag which specifies if recurring scans is enabled or disabled. Defaults to `false`.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 60 minutes) Used when creating the Vulnerability Assessment.
 - `delete` - (Defaults to 60 minutes) Used when deleting the Vulnerability Assessment.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Vulnerability Assessment.
 - `update` - (Defaults to 60 minutes) Used when updating the Vulnerability Assessment.
DESCRIPTION
  default     = null
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
DESCRIPTION  
  nullable    = false

  validation {
    condition     = alltrue([for _, v in var.diagnostic_settings : contains(["Dedicated", "AzureDiagnostics"], v.log_analytics_destination_type)])
    error_message = "Log analytics destination type must be one of: 'Dedicated', 'AzureDiagnostics'."
  }
  validation {
    condition = alltrue(
      [
        for _, v in var.diagnostic_settings :
        v.workspace_resource_id != null || v.storage_account_resource_id != null || v.event_hub_authorization_rule_resource_id != null || v.marketplace_partner_resource_id != null
      ]
    )
    error_message = "At least one of `workspace_resource_id`, `storage_account_resource_id`, `marketplace_partner_resource_id`, or `event_hub_authorization_rule_resource_id`, must be set."
  }
}


variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
DESCRIPTION
  nullable    = false
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
DESCRIPTION

  validation {
    condition     = var.lock != null ? contains(["CanNotDelete", "ReadOnly"], var.lock.kind) : true
    error_message = "The lock level must be one of: 'None', 'CanNotDelete', or 'ReadOnly'."
  }
}

variable "managed_identities" {
  description = "The configuration for managed identities. Includes system-assigned and user-assigned identities."
  type = object({
    system_assigned            = bool
    user_assigned_resource_ids = list(string)
  })
}


variable "user_assigned_identity_ids" {
  description = "A list of user-assigned managed identity IDs."
  type        = list(string)
  default     = []
}

variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    tags                                    = optional(map(string), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default     = {}
  description = <<DESCRIPTION
A map of private endpoints to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the private endpoint. One will be generated if not set.
- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
- `tags` - (Optional) A mapping of tags to assign to the private endpoint.
- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of this resource.
- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the IP configuration.
  - `private_ip_address` - The private IP address of the IP configuration.
DESCRIPTION
  nullable    = false
}

variable "enable_advanced_threat_protection" {
  type        = bool
  default     = true
  description = "(Optional) Whether to enabled Defender for SQL Advanced Threat Protection."
  nullable    = false
}

variable "storage_account_access_key" {
  description = "Primary access key for the storage account."
  type        = string
}

variable "storage_endpoint" {
  description = "Primary blob endpoint for the storage account."
  type        = string
}

variable "vulnerability_assessment_emails" {
  description = "List of email addresses for vulnerability assessment recurring scans"
  type        = list(string)
  default     = []
}

variable "storage_container_path" {
  description = "Primary container path for the storage account."
  type        = string

}

variable "principal_id" {
  description = "The principal ID for the MSSQL encryption."
  type        = string
}

variable "sql_diag_logs" {
  description = "NSG Monitoring Category details for Azure Diagnostic setting"
  default     = ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"]
}

variable "log_analytics_workspace_id" {
  description = "The name of log analytics workspace resource id"
  default     = null
}

variable "storage_account_id" {
  description = "The name of the hub storage account to store logs"
  default     = null
}


variable "key_vault_id" {
  description = "The ID of the Key Vault where the disk encryption key is stored"
  type        = string
}

variable "mssql_encryption_principal_id" {
  description = "The principal ID for the MSSQL encryption."
  type        = string
}

variable "mssql_encryption_tenant_id" {
  description = "The tenant ID for the MSSQL encryption."
  type        = string
}

variable "advanced_threat_protection_email_addresses" {
  description = "Email addresses to send advanced threat protection alerts to."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for email in var.advanced_threat_protection_email_addresses : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))])
    error_message = "Each email address must be a valid email format."
  }

    validation {
        condition     = length(var.advanced_threat_protection_email_addresses) <= 5
        error_message = "You can specify a maximum of 5 email addresses for advanced threat protection alerts."
    }
}

variable "advanced_threat_protection_storage_endpoint" {
    description = "The storage endpoint for advanced threat protection logs."
    type        = string
    default     = null
    
    validation {
        condition     = can(regex("^https?://[a-zA-Z0-9.-]+/.*$", var.advanced_threat_protection_storage_endpoint))
        error_message = "The storage endpoint must be a valid URL."
    }
  
}

variable "advanced_threat_protection_storage_account_access_key" {
    description = "The access key for the storage account used for advanced threat protection logs."
    type        = string
    default     = null
    
    validation {
        condition     = length(var.advanced_threat_protection_storage_account_access_key) >= 32
        error_message = "The storage account access key must be at least 32 characters long."
    }
  
}   