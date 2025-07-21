############################
# Azure Storage Queue Module
############################

resource "azurerm_storage_queue" "this" {
  for_each = { for queue in var.queues : queue.name => queue }

  name                 = each.key
  storage_account_name = var.storage_account_name
  metadata             = each.value.metadata
}
