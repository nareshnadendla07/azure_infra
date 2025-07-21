output "extension_names" {
  value = { for k, v in azurerm_virtual_machine_extension.domjoin : k => v.name }
}
