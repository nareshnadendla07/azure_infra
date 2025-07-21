############################
## Existing Private Endpoint
############################

data "azurerm_private_endpoint" "this" {
  name                = var.private_endpoint_name
  resource_group_name = var.resource_group_name
}

#######################################################
## Private DNS Zone Group for Existing Private Endpoint
#######################################################

resource "azurerm_private_dns_zone_group" "this" {
  name                = var.dns__zone_group_name
  private_endpoint_id = data.azurerm_private_endpoint.this.id

  dynamic "private_dns_zone" {
    for_each = var.private_dns_resource_ids
    content {
      name                 = last(split("/", private_dns_zone.value))
      private_dns_zone_id  = private_dns_zone.value
    }
  }
}