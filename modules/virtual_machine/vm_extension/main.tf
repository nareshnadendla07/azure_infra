resource "azurerm_virtual_machine_extension" "this" {
  for_each                   = var.virtual_machines
  name                       = format("%s-%s", var.extension_name, each.key)
  virtual_machine_id         = each.value.vm_id
  publisher                  = var.publisher
  type                       = var.type
  type_handler_version       = var.type_handler_version
  auto_upgrade_minor_version = false

  settings = jsonencode({
    commandToExecute = var.command_to_execute

  })

}
