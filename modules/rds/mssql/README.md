
# Azure MSSQL Server and Database Terraform Module

This module deploys an Azure MSSQL Server and database instance with optional configuration for:
- Primary and secondary servers
- Threat detection policies
- Extended auditing
- Vulnerability assessments
- SQL failover group (commented)
- Initialization via `sqlcmd`
- Monitoring with Diagnostic Settings
- Key Vault integration for Transparent Data Encryption (TDE)
- SQL firewall rules

## 📦 Features

- Deploys both **primary** and **secondary** SQL Servers.
- Configures extended auditing and threat detection policies.
- Supports long-term and short-term retention.
- Sets up vulnerability assessments at server and database levels.
- Optional `sqlcmd` script for initializing a database schema.
- Monitors logs and metrics using Log Analytics workspace.
- Configurable firewall rules and security policies.

## 📁 Resources

- `azurerm_mssql_server`
- `azurerm_mssql_database`
- `azurerm_mssql_server_extended_auditing_policy`
- `azurerm_mssql_database_threat_detection_policy`
- `azurerm_mssql_database_vulnerability_assessment`
- `azurerm_mssql_server_security_alert_policy`
- `azurerm_mssql_firewall_rule`
- `azurerm_mssql_database_extended_auditing_policy`
- `azurerm_key_vault_access_policy`
- `azurerm_monitor_diagnostic_setting`
- `null_resource` (for SQL init with sqlcmd)

## 🔧 Inputs

| Variable                                | Description                                                  |
|-----------------------------------------|--------------------------------------------------------------|
| `sqlserver_name`                        | SQL Server base name                                         |
| `location`                              | Azure region                                                 |
| `resource_group_name`                   | Resource group for the SQL Server                           |
| `admin_username`                        | Administrator login name                                     |
| `admin_password`                        | Administrator password                                       |
| `sql_version`                           | SQL Server version                                           |
| `enable_failover_group`                 | Enable secondary SQL Server                                  |
| `enable_threat_detection_policy`        | Enable threat detection for the database                     |
| `enable_log_monitoring`                | Enable Diagnostic Settings                                   |
| `enable_vulnerability_assessment`       | Enable vulnerability assessment                              |
| `enable_firewall_rules`                | Enable firewall rules configuration                          |
| `identity`                              | Toggle to enable Managed Identity                            |
| `identity_ids`                          | List of user-assigned identity IDs                           |
| `transparent_data_encryption_key_vault_key_id` | Key Vault key ID for TDE                                  |
| `storage_endpoint`                      | Storage blob endpoint for logging                            |
| `storage_account_access_key`            | Storage account access key                                   |
| `storage_account_id`                    | Storage account resource ID                                  |
| `log_analytics_workspace_id`            | Log Analytics Workspace ID                                   |
| `log_retention_days`                    | Number of days to retain logs                                |
| `database_name`                         | SQL Database name                                            |
| `retention_days`                        | Short-term backup retention days                             |
| `backup_interval_in_hours`             | Backup interval                                              |
| `weekly_retention`, `monthly_retention`, `yearly_retention` | LTR policies                         |
| `week_of_year`                          | Week number for yearly LTR                                   |
| `email_addresses_for_alerts`           | Email list for threat and vulnerability alerts               |
| `disabled_alerts`                       | List of alerts to disable                                    |
| `initialize_sql_script_execution`       | Toggle to run SQL script using sqlcmd                        |
| `sqldb_init_script_file`                | Path to SQL init script file                                 |
| `firewall_rules`                        | List of firewall rules `{name, start_ip_address, end_ip_address}` |

## 🔐 Security & Compliance

- Includes Key Vault access policy for encryption keys.
- Ensures secure auditing with optional access key management.
- Role-based access is enforced via `identity` blocks.

## 👨‍💻 Author

This module is maintained by [Naresh Nadendla].

Contributions, improvements, and suggestions are welcome!
