# terraform.tfvars

vnet_name = "p-eau-proc-vnet"

virtual_network_name = "p-eau-proc-vnet"

location = "australiaeast"

resource_group_name = "p-eau-proc-rg"

address_prefixes = ["/24"]

dns_servers = [""]

log_analytics_workspace_name = "p-global-secops-law"



tags = {
  BusinessUnit = "LS"
  environment  = " proc"
  Product      = "proc"
}

#########
## Subnet
#########

nuix_subnet_name = "p-eau-nuix-snet"

nuix_subnet_address_prefix = 

forensic_subnet_name = "p-eau-frc-snet"

forensic_subnet_address_prefix = 

download_subnet_name = "p-eau-dnl-snet"

download_subnet_address_prefix =

default_subnet_name = "p-eau-default-snet"

default_subnet_address_prefix = 

core_subnet_name = "p-eau-core-snet"

core_subnet_address_prefix = 

sql_subnet_name = "p-eau-sql-snet"

sql_subnet_address_prefix =

public_subnet_name = "p-eau-proc-public-snet"

public_subnet_address_prefix =


###################
## Availability set
###################

availability_set_name = "p-eau-avail"

proximity_name = "p-eau-proxigrp"

######
## NSG
######

# nuix_nsg_name = "p-eau-nuix-nsg"

forensic_nsg_name = "p-eau-frc-nsg"

download_nsg_name = "p-eau-dnl-nsg"

smb_nsg_name = "p-eau-smb-nsg"

mwd_nsg_name = "p-eau-mwd-nsg"

default_nsg_name = "p-eau-default-nsg"

misql_nsg_name = "p-eau-misql-nsg"

######
## ASG
######

nuix_asg_name = "p-eau-nuix-asg"

forensic_asg_name = "p-eau-frc-asg"

download_asg_name = "p-eau-dnl-asg"

smb_asg_name = "p-eau-smb-asg"

mwd_asg_name = "p-eau-mwd-asg"


##################
## Storage Account
##################

storage_account_name                      = "test"
account_tier                              = "Standard"
account_rlication_type                  = "ZRS"
account_kind                              = "StorageV2"
container_delete_retention_policy_in_days = 7
blob_soft_delete_retention_days           = 7
is_versioning_enabled                     = false
change_feed_enabled                       = true
change_feed_retention_in_days             = 30
delete_retention_policy_days              = 30
last_access_time_tracking_policy_enabled  = false
queue_retention_policy_days               = 7
default_service_version                   = "2020-02-10"

###################
## managed_identity 
###################

managed_identity_name = "p-eau-proc-id"

###########
## KeyVault
###########

key_vault_name             = "p-eau-proc-kv"
key_vault_key_name  = "p-eau-proc-kv-disk-key"

key_vault_sku_pricing_tier = "standard"
enable_rbac                = false


## Private Endpoint 


########
## MSSQL
########

managed_instance_name          = "p-eau-proc-mng-sql"
sku_name                       = "GP_Gen5"
sku_edition                    = "GeneralPurpose"
vcores                         = 8
administrator_login            = "sqladmin"
storage_size_in_gb             = 256
collation                      = "SQL_Latin1_General_CP1_CI_AS"
timezone_id                    = "UTC"
public_data_endpoint_enabled   = false
license_type                   = "LicenseIncluded"
hybrid_secondary_usage         = null
dns_zone_partner_id            = null
minimum_tls_version            = null
storage_account_type           = "LRS"
zone_redundant_enabled         = false
maintenance_configuration_name = null
managed_instance_tags          = {}
enable_defender                = true

# sqlserver_name = "p-eau-proc-sqldb"

# sql_version = "12.0"

# admin_username = "sqladmin"

# database_name = "demomssqldb"

# sql_database_edition = "Standard"

# sqldb_service_objective_name = "S1"



##################
## Compute Gallery
##################

compute_gallery = {
  "gallery1" = {
    name        = "peauprocgal"
    description = "The default compute gallery used within the azure platform"

  }
}

######
## NIC
######

primary                       = true
private_ip_allocation_method  = "Dynamic"
enable_accelerated_networking = false
enable_ip_forwarding          = false


#####
## VM
#####

nuix_vm_name = "p-eau-nuix-vm"

forensic_vm_name = "p-eau-frc-vm"

download_vm_name = "p-eau-dnl-vm"

smb_vm_name = "p-eau-smb-vm"

mwd_vm_name = "p-eau-mwd-vm"

nuix_vm_size = "Standard_E32ads_v5"

dnl_vm_size = "Standard_B8als_v2"

frc_vm_size = "Standard_E32ads_v5"

smb_vm_size = "Standard_E8as_v5"

mwd_vm_size = "Standard_B2als_v2"

win_admin_username = "PowerAdmin"

image_reference = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-Datacenter"
  version   = "latest"
}

win_os_disk = {
  name              = "p-eau-win-os-disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "Standard_LRS"
  disk_size_gb      = 150
}

win_rm = [
  {
    protocol = "http"
    port     = 5985
  }
]

script_name = "attach-disk.ps1"


