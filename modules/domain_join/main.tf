resource "azurerm_virtual_machine_extension" "domjoin" {
  for_each             = var.virtual_machines
  name                 = "domjoin-${each.key}"
  virtual_machine_id   = each.value.vm_id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = jsonencode({
    "Name" : var.domain_name,
    "OUPath" : var.ou_path,
    "User" : var.domain_user,
    "Restart" : "true",
    "Options" : "3"
  })

  protected_settings = jsonencode({
    "Password" : var.domain_password
  })

  
}
