data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

#########
## Subnet
#########

resource "azurerm_subnet" "snet" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }
  name                 = each.value.name
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = lookup(each.value, "service_endpoints", [])

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", null) != null ? [1] : []
    content {
      name = lookup(each.value.delegation, "name", null)
      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", [])
      }
    }
  }

  private_endpoint_network_policies = each.value.private_endpoint_network_policies 
  
}
