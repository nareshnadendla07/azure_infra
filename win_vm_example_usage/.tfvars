# terraform.tfvars

vnet_name = "p-eau-proc-vnet"

virtual_network_name = "p-eau-proc-vnet"

location = "australiaeast"

resource_group_name = "p-eau-proc-rg"

address_prefixes = ["172.19.6.0/24"]

dns_servers = ["172.19.0.132"]

log_analytics_workspace_name = "p-global-secops-law"

log_analytics_workspace_id = "/subscriptions/3b862a13-3ce3-4197-bc0c-31cb70b5a579/resourceGroups/p-global-workspace-rg/providers/Microsoft.OperationalInsights/workspaces/p-global-secops-law"


tags = {
  BusinessUnit = "LS"
  environment  = " proc"
  Product      = "proc"
}

#########
## Subnet
#########

nuix_subnet_name = "p-eau-nuix-snet"

nuix_subnet_address_prefix = "172.19.8.0/26"

forensic_subnet_name = "p-eau-frc-snet"

forensic_subnet_address_prefix = "172.19.6.0/26"

download_subnet_name = "p-eau-dnl-snet"

download_subnet_address_prefix = "172.19.6.64/28"

default_subnet_name = "p-eau-default-snet"

default_subnet_address_prefix = "172.19.6.128/28"

core_subnet_name = "p-eau-core-snet"

core_subnet_address_prefix = "172.19.6.160/27"

sql_subnet_name = "p-eau-sql-snet"

sql_subnet_address_prefix = "172.19.6.192/27"

public_subnet_name = "p-eau-proc-public-snet"

public_subnet_address_prefix = "172.19.6.80/28"


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

storage_account_name                      = "peauprocst"
evd_storage_account_name                  = "peauprocevidencest"
cases_storage_account_name                = "peauproccasesst"
matter_storage_account_name               = "peauprocmattersst"
legal_storage_account_name                = "peauproclegalst"
admin_storage_account_name                = "peauprocadminst"
nuix_storage_account_name                 = "peauprocnuixst"
tmp_storage_account_name                  = "peauproctmpst"
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
certificate_name          = "star-ashurstsolutions-com"
certificate_pfx_file_path = "./star_ashurstsolutions_com.pfx"
certificate_subject       = "SSL Certificate for My WorkDrive Application GateWay"
certificate_password      = "goanywhere"

## Private Endpoint 

mssql_private_dns_zone_resource_ids = ["subscriptions/a5e05aaf-3ac0-40e9-bf67-e70a4817ee70/resourceGroups/p-azdns-zones-rg/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"]

sa_private_dns_zone_resource_ids = [
  "subscriptions/a5e05aaf-3ac0-40e9-bf67-e70a4817ee70/resourceGroups/p-azdns-zones-rg/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"
]

evd_private_dns_zone_resource_ids = [
  "subscriptions/a5e05aaf-3ac0-40e9-bf67-e70a4817ee70/resourceGroups/p-azdns-zones-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
]


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


