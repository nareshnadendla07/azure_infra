#########################
# Private Endpoint Module
#########################

resource "azurerm_private_endpoint" "this" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_resource_id
  tags                = merge({ "Name" = format("%s", var.private_endpoint_name) }, var.tags)

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
    }
  }

  dynamic "private_service_connection" {
    for_each = length(var.private_link_service_connections) > 0 ? var.private_link_service_connections : []
    content {
      name                           = private_service_connection.value.name
      is_manual_connection           = false
      subresource_names              = private_service_connection.value.subresource_names
      private_connection_resource_id = private_service_connection.value.private_connection_resource_id
    }
  }


  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_resource_ids) > 0 ? [var.private_dns_zone_group_name] : []
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = var.private_dns_zone_resource_ids
    }
  }
#   private_dns_zone_group {
#     name                 = var.private_dns_zone_group_name
#     private_dns_zone_ids = var.private_dns_zone_resource_ids


#   }
}
