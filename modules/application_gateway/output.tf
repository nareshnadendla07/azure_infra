output "application_gateway_id" {
  value = azurerm_application_gateway.example.id
}

output "public_ip_addresses" {
  value = [for config in var.frontend_ip_configurations : config["properties"]["public_ip_address"]["id"]]
}
output "frontend_ip_configuration_ids" {
  value = [for config in var.frontend_ip_configurations : azurerm_application_gateway_frontend_ip_configuration.example[config.name].id]
}