###########################################
# Azure Virtual Machine Registration Module
###########################################

resource "azurerm_virtual_machine_extension" "register_avd" {
  count                      = var.instances_count
  name                       = "${var.extension_name_prefix}_${count.index}"
  virtual_machine_id         = var.virtual_machine_ids[count.index]
  publisher                  = var.publisher
  type                       = var.type
  type_handler_version       = var.type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version

  settings = jsonencode({
    modulesUrl            = var.modules_url,
    configurationFunction = var.configuration_function,
    properties = {
      hostPoolName          = var.host_pool_name,
      registrationInfoToken = var.registration_token
    }
  })

  lifecycle {
    ignore_changes = [settings]
  }
}

