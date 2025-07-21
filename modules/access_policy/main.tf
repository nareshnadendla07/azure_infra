################################################
# Key Vault Access Policy for Storage Encryption
################################################

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.principal_id

  secret_permissions = var.secret_permissions
  key_permissions    = var.key_permissions
  certificate_permissions = var.certificate_permissions
}
