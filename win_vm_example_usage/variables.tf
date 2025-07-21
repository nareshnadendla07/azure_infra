variable "client_id" {
  description = "The ID of the SPN client"
  type        = string
  
}

variable "client_secret" {
  description = "The Secret of the SPN client"
  type        = string
  
}

variable "tenant_id" {
  description = "The ID of the SPN Tenant"
  type        = string
  
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Specifies the ID of a Log Analytics Workspace where Diagnostics Data to be sent"
  default     = null
  type        = string
}

variable "address_prefixes" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "dns_servers" {
  description = "List of DNS servers"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be applied to the resources"
  type        = map(string)
}

variable "virtual_network_name" {
  description = "The name of the existing virtual network"
  type        = string
}


#########################
## Log Analytics variable
#########################


variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}


###################
## Subnet Variables
###################

variable "nuix_subnet_name" {
  description = "The name of the nuix subnet"
  type = string

}

variable "nuix_subnet_address_prefix" {
  description = "The address prefix of nuix subnet"
  type = string

}

variable "forensic_subnet_name" {
  description = "The name of the forensic subnet"
  type        = string

}

variable "forensic_subnet_address_prefix" {
  description = "The address prefix of forensic subnet"
  type        = string

}

variable "download_subnet_name" {
  description = "The name of the download subnet"
  type        = string

}

variable "download_subnet_address_prefix" {
  description = "The address prefix of download subnet"
  type        = string

}

variable "default_subnet_name" {
  description = "The name of the default subnet"
  type        = string

}

variable "default_subnet_address_prefix" {
  description = "The address prefix of default subnet"
  type        = string

}

variable "core_subnet_name" {
  description = "The name of the core subnet"
  type        = string

}

variable "core_subnet_address_prefix" {
  description = "The address prefix of core subnet"
  type        = string

}

variable "sql_subnet_name" {
  description = "The name of the core subnet"
  type        = string

}

variable "sql_subnet_address_prefix" {
  description = "The address prefix of core subnet"
  type        = string

}

variable "public_subnet_name" {
  description = "The name of the core subnet"
  type        = string

}

variable "public_subnet_address_prefix" {
  description = "The address prefix of core subnet"
  type        = string

}



################
## NSG Variables
################

# variable "nuix_nsg_name" {
#   description = "The name of the nuix NSG"
#   type = string

# }

variable "forensic_nsg_name" {
  description = "The name of the forensic NSG"
  type        = string

}

variable "download_nsg_name" {
  description = "The name of the download NSG"
  type        = string

}

variable "smb_nsg_name" {
  description = "The name of the File Server NSG"
  type        = string

}

variable "mwd_nsg_name" {
  description = "The name of the My Work Drive NSG"
  type        = string

}

variable "default_nsg_name" {
  description = "The name of the default NSG"
  type        = string

}

variable "misql_nsg_name" {
  description = "The name of the default NSG"
  type        = string

}
################
## ASG Variables
################

variable "nuix_asg_name" {
  description = "The name of the nuix ASG"
  type = string

}

variable "forensic_asg_name" {
  description = "The name of the forensic ASG"
  type        = string

}

variable "download_asg_name" {
  description = "The name of the download ASG"
  type        = string

}

variable "smb_asg_name" {
  description = "The name of the File Server ASG"
  type        = string

}

variable "mwd_asg_name" {
  description = "The name of the My Work Drive ASG"
  type        = string

}



##################
## storage account
##################

variable "storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "evd_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "cases_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "matter_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "legal_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "admin_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "nuix_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "tmp_storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "account_tier" {
  description = "The tier for the storage account."
  type        = string

}


variable "account_replication_type" {
  description = "The type of replication to use for the storage account."
  type        = string

}
variable "account_kind" {
  description = "The type of kind to use for the storage account."
  type        = string

}

variable "container_delete_retention_policy_in_days" {
  description = "Number of days to retain deleted blobs in containers."
  type        = number
}

variable "blob_soft_delete_retention_days" {
  description = "The number of days to retain deleted blobs for the entire storage account."
  type        = number
}

variable "is_versioning_enabled" {
  description = "Global setting to enable versioning across blob storage."
  type        = bool
}

variable "change_feed_enabled" {
  description = "Enables the change feed feature for blob storage."
  type        = bool
}

variable "change_feed_retention_in_days" {
  description = "Indicates the duration of change feed retention in days."
  type        = number
}

variable "last_access_time_tracking_policy_enabled" {
  description = "Indicates whether last access time tracking is enabled for blobs in the storage account."
  type        = bool
}

variable "queue_retention_policy_days" {
  description = "The number of days to retain messages in queues."
  type        = number
}

variable "default_service_version" {
  description = "The default service version for requests to the storage account."
  type        = string
}

variable "mssql_private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}

variable "sa_private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}

variable "evd_private_dns_zone_resource_ids" {
  description = "The private DNS zone groups to associate with the private endpoint. A DNS zone group can support up to 5 DNS zones."
  type        = list(string)
  default     = []
}

variable "delete_retention_policy_days" {
  description = "The number of days to retain deleted blobs for the entire storage account."
  type        = number
}

############################
## Managed Identity varibles
############################

variable "managed_identity_name" {
  description = "The name of the Managed Identity"
  type        = string
}

######################
## key vault variables
######################


variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "key_vault_key_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "key_vault_sku_pricing_tier" {
  description = "The SKU pricing tier for the Key Vault"
  type        = string
}

variable "enable_rbac" {
  type = bool
}

variable "certificate_name" {
  description = "The name of the certificate in Azure Key Vault"
  type        = string
}

variable "certificate_pfx_file_path" {
  description = "The local path to the PFX file"
  type        = string
}

variable "certificate_password" {
  description = "The password for the PFX certificate"
  type        = string
}

variable "certificate_subject" {
  description = "The subject for the certificate (e.g., CN=example.com)"
  type        = string
}


###################
## Compute Gallerry
###################

variable "compute_gallery" {
  description = "Map of compute gallery configurations"
  type = map(object({
    name        = string
    description = string
    sharing = optional(object({
      permission = optional(string, "Groups")
      community_gallery = optional(object({
        eula            = string
        prefix          = string
        publisher_email = string
        publisher_uri   = string
      }))
    }))
  }))
}

###################
## MS SQl Variables
###################

variable "managed_instance_name" {
  description = "The name of the Managed Instance."
  type        = string
}

variable "sku_name" {
  description = "Managed instance SKU."
  type        = string
}

variable "sku_edition" {
  description = "SKU Edition for the Managed Instance."
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

variable "hybrid_secondary_usage" {
  description = "Determines whether Hybrid failover rights benefit is activated."
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

variable "managed_instance_tags" {
  description = "Resource tags to associate with the instance."
  type        = map(string)
}

variable "enable_defender" {
  description = "Enable Microsoft Defender for SQL."
  type        = bool
  default     = false
}


###############
## VM Variables
###############

variable "nuix_vm_name" {
  description = "The name of nuix vm"
  type = string

}

variable "forensic_vm_name" {
  description = "The name of forensic vm"
  type        = string

}

variable "download_vm_name" {
  description = "The name of download vm"
  type        = string

}

variable "smb_vm_name" {
  description = "The name of file server vm"
  type        = string

}

variable "mwd_vm_name" {
  description = "The name of My work Drive vm"
  type        = string

}

variable "nuix_vm_size" {
  description = "Specifies the size for nuix VMs."
  type        = string
}

variable "dnl_vm_size" {
  description = "Specifies the size for Download VMs."
  type        = string
}

variable "frc_vm_size" {
  description = "Specifies the size for forensic VMs."
  type        = string
}

variable "smb_vm_size" {
  description = "Specifies the size for forensic VMs."
  type        = string
}

variable "mwd_vm_size" {
  description = "Specifies the size for forensic VMs."
  type        = string
}

variable "image_reference" {
  description = "OS image reference."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "win_os_disk" {
  description = "Specifies the OS disk."
  type = object({
    name              = string
    caching           = string
    create_option     = string
    managed_disk_type = string
    disk_size_gb      = number
  })
}

variable "win_admin_username" {
  description = "Administrator username."
  type        = string
}


variable "disable_password_authentication" {
  description = "Specifies whether password authentication should be disabled."
  type        = bool
  default     = false
}

variable "provision_vm_agent" {
  description = "Indicates whether virtual machine agent should be provisioned on the virtual machine."
  type        = bool
  default     = true
}

variable "enable_automatic_updates" {
  description = "Indicates whether Automatic Updates is enabled for the Windows virtual machine."
  type        = bool
  default     = true
}
variable "win_rm" {
  description = "Specifies the Windows Remote Management listeners."
  type = list(object({
    protocol = string
    port     = number
  }))
  default = []
}

variable "script_name" {
  description = "The name of the PowerShell script that will run to attach the disk"
  type        = string
}

#######################
## Domain join Variable
#######################

variable "domain_password" {
  description = "The password for the domain user."
  type        = string
  sensitive   = true
}


################
## NIC Variables
################

variable "primary" {
  description = "Specifies whether the IP configuration is primary. Default is true."
  type        = bool

}

variable "private_ip_allocation_method" {
  description = "Private IP allocation method (Static or Dynamic)."
  type        = string

}

variable "enable_accelerated_networking" {
  description = "Whether accelerated networking is enabled. Default is false."
  type        = bool

}

variable "enable_ip_forwarding" {
  description = "Whether IP forwarding is enabled on this NIC. Default is false."
  type        = bool

}


variable "availability_set_name" {
  description = "The name of the availability set"
  type        = string

}

variable "proximity_name" {
  description = "The name of the proximity group."
  type        = string
  default     = ""
}
