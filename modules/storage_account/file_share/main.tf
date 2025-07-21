#################################
# Azure Storage File Share Module
#################################

resource "azurerm_storage_share" "this" {
  for_each = { for share in var.file_shares : share.name => share }

  name                 = each.value.name
  storage_account_id = var.storage_account_id
  quota                = each.value.quota
  metadata             = each.value.metadata
}
