data "azuread_group" "adgrp" {
  for_each     = toset(local.azure_ad_group_names)
  display_name = each.value
}

data "azuread_user" "adusr" {
  for_each            = toset(local.azure_ad_user_principal_names)
  user_principal_name = each.value
}

data "azuread_service_principal" "adspn" {
  for_each     = toset(local.azure_ad_service_principal_names)
  display_name = each.value
}

data "azurerm_client_config" "current" {}

locals {
  access_policies = [
    for p in var.access_policies : merge({
      azure_ad_group_names             = []
      object_ids                       = []
      azure_ad_user_principal_names    = []
      certificate_permissions          = []
      key_permissions                  = []
      secret_permissions               = []
      storage_permissions              = []
      azure_ad_service_principal_names = []
    }, p)
  ]

  azure_ad_group_names             = distinct(flatten(local.access_policies[*].azure_ad_group_names))
  azure_ad_user_principal_names    = distinct(flatten(local.access_policies[*].azure_ad_user_principal_names))
  azure_ad_service_principal_names = distinct(flatten(local.access_policies[*].azure_ad_service_principal_names))

  # group_object_ids = { for g in data.azuread_group.adgrp : lower(g.display_name) => g.id }
  # user_object_ids  = { for u in data.azuread_user.adusr : lower(u.user_principal_name) => u.id }
  # spn_object_ids   = { for s in data.azuread_service_principal.adspn : lower(s.display_name) => s.id }
  group_object_ids = {
    for g in data.azuread_group.adgrp :
    lower(g.display_name) => replace(g.id, "//groups//", "")
  }

  user_object_ids = {
    for u in data.azuread_user.adusr :
    lower(u.user_principal_name) => replace(u.id, "//users//", "")
  }

  spn_object_ids = {
    for s in data.azuread_service_principal.adspn :
    lower(s.display_name) => replace(s.id, "//servicePrincipals//", "")
  }

  flattened_access_policies = concat(
    flatten([
      for p in local.access_policies : flatten([
        for i in p.object_ids : {
          object_id               = i
          certificate_permissions = p.certificate_permissions
          key_permissions         = p.key_permissions
          secret_permissions      = p.secret_permissions
          storage_permissions     = p.storage_permissions
        }
      ])
    ]),
    flatten([
      for p in local.access_policies : flatten([
        for n in p.azure_ad_group_names : {
          object_id               = local.group_object_ids[lower(n)]
          certificate_permissions = p.certificate_permissions
          key_permissions         = p.key_permissions
          secret_permissions      = p.secret_permissions
          storage_permissions     = p.storage_permissions
        }
      ])
    ]),
    flatten([
      for p in local.access_policies : flatten([
        for n in p.azure_ad_user_principal_names : {
          object_id               = local.user_object_ids[lower(n)]
          certificate_permissions = p.certificate_permissions
          key_permissions         = p.key_permissions
          secret_permissions      = p.secret_permissions
          storage_permissions     = p.storage_permissions
        }
      ])
    ]),
    flatten([
      for p in local.access_policies : flatten([
        for n in p.azure_ad_service_principal_names : {
          object_id               = local.spn_object_ids[lower(n)]
          certificate_permissions = p.certificate_permissions
          key_permissions         = p.key_permissions
          secret_permissions      = p.secret_permissions
          storage_permissions     = p.storage_permissions
        }
      ])
    ])
  )

  grouped_access_policies = { for p in local.flattened_access_policies : p.object_id => p... }

  combined_access_policies = [
    for k, v in local.grouped_access_policies : {
      object_id               = k
      certificate_permissions = distinct(flatten(v[*].certificate_permissions))
      key_permissions         = distinct(flatten(v[*].key_permissions))
      secret_permissions      = distinct(flatten(v[*].secret_permissions))
      storage_permissions     = distinct(flatten(v[*].storage_permissions))
    }
  ]

  service_principal_object_id = data.azurerm_client_config.current.object_id

  self_permissions = {
    object_id               = local.service_principal_object_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
    key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
    certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
    storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
  }

  sanitized_secrets = {
    for k, v in var.secrets :
    # Replace any invalid characters with dashes
    replace(k, "[^a-zA-Z0-9-]", "-") => v
  }
}


####################
# Key Vault Resource
####################

resource "azurerm_key_vault" "main" {
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.key_vault_sku_pricing_tier
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.enable_purge_protection
  tags                            = merge({ "ResourceName" = lower("kv-${var.key_vault_name}") }, var.tags, )

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [true] : []
    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  dynamic "access_policy" {
    for_each = local.combined_access_policies
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }

  dynamic "access_policy" {
    for_each = local.service_principal_object_id != "" ? [local.self_permissions] : []
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value.object_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }


  dynamic "contact" {
    for_each = var.certificate_contacts
    content {
      email = contact.value.email
      name  = contact.value.name
      phone = contact.value.phone
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

####################################################################################
# Keyvault Secret - Random password Creation if value is empty - Default is "false"
####################################################################################


resource "azurerm_key_vault_secret" "keys" {
  for_each     = local.sanitized_secrets
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.main.id

  lifecycle {
    ignore_changes = [
      tags,
      value,
    ]
  }
}


###################################
# Key Vault Key for Disk Encryption
###################################

resource "azurerm_key_vault_key" "disk_encryption_key" {
  # Conditional resource creation based on enable_disk_encryption variable
  count        = var.enable_disk_encryption ? 1 : 0
  name         = var.key_name
  key_vault_id = azurerm_key_vault.main.id
  # Variable for the Key Vault ID
  key_type = "RSA"
  key_size = 2048
  depends_on = [
    azurerm_key_vault.main
  ]
  key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
  tags = merge({ "Name" = format("%s", var.key_name) }, var.tags)

}

####################################
# Key Vault Key for MSSQL Encryption
####################################

resource "azurerm_key_vault_key" "mssql_encryption_key" {
  count        = var.enable_mssql_encryption ? 1 : 0
  name         = var.mssql_key_name # Variable for the key name
  key_vault_id = azurerm_key_vault.main.id
  # Variable for the Key Vault ID
  key_type = "RSA"
  key_size = 2048
  depends_on = [
    azurerm_key_vault.main
  ]
  key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
  tags = merge({ "Name" = format("%s", var.mssql_key_name) }, var.tags)
}

######################################
# Key Vault Key for Storage Encryption
######################################

resource "azurerm_key_vault_key" "storage_encryption_key" {
  count        = var.enable_storage_encryption ? 1 : 0
  name         = var.st_key_name # Variable for the key name
  key_vault_id = azurerm_key_vault.main.id
  # Variable for the Key Vault ID
  key_type = "RSA"
  key_size = 2048
  depends_on = [
    azurerm_key_vault.main
  ]
  key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }

  tags = merge({ "Name" = format("%s", var.st_key_name) }, var.tags)

}

#######################
# Key Vault Certificate
#######################

resource "azurerm_key_vault_certificate" "example_certificate" {
  count = var.enable_certificate ? 1 : 0   
  name         = var.certificate_name
  key_vault_id = azurerm_key_vault.main.id

  certificate {
    contents = filebase64(var.certificate_pfx_file_path) # Reads the base64-encoded PFX file from your local system
    password = var.certificate_password                  # The password for the PFX file
  }

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      validity_in_months = 12
      subject            = "CN=${var.certificate_subject}"
      key_usage = [
        "digitalSignature",
        "keyEncipherment",
        "dataEncipherment",
        "keyAgreement",
        "keyCertSign",
        "cRLSign",
        "encipherOnly",
        "decipherOnly"
      ]
    }

  }
}

###########################################
# azurerm monitoring diagnostics - KeyVault
###########################################

resource "azurerm_monitor_diagnostic_setting" "kv_diagnostics" {
  name                       = "${var.key_vault_name}-diag"
  target_resource_id         = azurerm_key_vault.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  #storage_account_id         = var.storage_account_id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_log {
    category = "AzurePolicyEvaluationDetails"
  }

  enabled_metric {
    category = "AllMetrics"    
  }
}
