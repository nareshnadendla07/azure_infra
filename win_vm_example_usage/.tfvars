##################
## Create KeyVault
##################

module "key_vault" {
  source              = "../../modules/keyvault"
  resource_group_name = var.resource_group_name
  location            = var.location

  key_vault_name             = var.key_vault_name
  key_vault_sku_pricing_tier = var.key_vault_sku_pricing_tier

  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = false
  enable_purge_protection         = true
  soft_delete_retention_days      = 90
  enable_private_endpoint         = false
  log_analytics_workspace_id      = var.log_analytics_workspace_id
  storage_account_id              = module.storage_account.storage_account_id

  mssql_key_name = "${var.key_vault_name}-mssql-key"
  key_name       = "${var.key_vault_name}-disk-key"
  st_key_name    = "${var.key_vault_name}-st-key"

  access_policies = [
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = module.managed_identity.principal_id
      key_permissions         = ["Get", "List", "Create", "Delete", "Update", "Recover", "Purge", "GetRotationPolicy", "WrapKey", "UnwrapKey"]
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "Import", "List"]
      storage_permissions     = ["Backup", "Get", "List", "Recover"]
    },
    {
      #object_id               = module.managed_identity.principal_id
      azure_ad_group_names    = ["Epiq Cloud Applications"]
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "Import", "List"]
      storage_permissions     = ["Backup", "Get", "List", "Recover"]
    },
    {
      #object_id               = module.managed_identity.principal_id
      azure_ad_group_names    = ["Epiq Cloud Engineering"]
      key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
      secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
      certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
      storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
    }
  ]

  secrets = {
    # "nuix-vm01-pass-PowerAdmin"     = module.random_password_nuix_vm[0].password
    # "nuix-vm02-pass-PowerAdmin"     = module.random_password_nuix_vm[1].password
    "forensic-vm01-pass-PowerAdmin" = module.random_password_forensic_vm[0].password
    # "forensic-vm02-pass-PowerAdmin" = module.random_password_forensic_vm[1].password
    "download-vm01-pass-PowerAdmin" = module.random_password_download_vm[0].password
    "mwd-vm-pass-PowerAdmin"        = module.random_password_mwd_vm[0].password
    "smb-vm-pass-PowerAdmin"        = module.random_password_smb_vm[0].password
    "mssql-pass-sqladmin"           = module.random_password_mssql.password
  }

  certificate_name          = var.certificate_name
  certificate_pfx_file_path = var.certificate_pfx_file_path
  certificate_subject       = var.certificate_subject
  certificate_password      = var.certificate_password

  # network_acls = {
  #   bypass         = "AzureServices" # Allow trusted Azure services to bypass firewall
  #   default_action = "Deny"          # Deny all by default
  #   ip_rules = [
  #     "13.55.103.100/32",
  #     "3.24.154.155/32",
  #     "52.62.43.57/32"
  #   ]
  #   virtual_network_subnet_ids = [

  #   ] 
  # }

  tags       = var.tags
  depends_on = [module.managed_identity]
}
