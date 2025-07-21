data "azurerm_client_config" "current" {}

################################################
# Disk Encryption Set for VM Disk Encryption
################################################
# Ensure the access policy is applied before the Disk Encryption Set is created
resource "azurerm_disk_encryption_set" "vm_disk_encryption" {
  name                      = var.disk_encryption_set_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  key_vault_key_id          = var.key_vault_key_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled

  identity {
    type = "SystemAssigned" # Use SystemAssigned managed identity
  }

  tags = var.tags
}

#############################################
# Key Vault Access Policy for Disk Encryption
#############################################

resource "azurerm_key_vault_access_policy" "disk_encryption" {
  key_vault_id = var.key_vault_id # Use the key_vault_id variable
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_disk_encryption_set.vm_disk_encryption.identity[0].principal_id

  key_permissions = ["Get", "WrapKey", "UnwrapKey"]
}

#########################################
# Role Assignment for Disk Encryption Set
#########################################

resource "azurerm_role_assignment" "disk_encryption_set_role_assignment" {
  scope                = azurerm_disk_encryption_set.vm_disk_encryption.id
  role_definition_name = "Disk Encryption Set Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}