#############################
## Azure Storage Table Module
#############################

resource "azurerm_storage_table" "this" {
  for_each = { for table in var.tables : table.name => table }

  name                 = each.key
  storage_account_name = var.storage_account_name
}
