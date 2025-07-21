##############
## Route Table
##############

resource "azurerm_route_table" "this" {
  name                          = var.rtname
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = var.enable_bgp_propagation
  tags                          = merge({ "Name" = var.rtname }, var.tags)


  dynamic "route" {
    for_each = var.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_type == "VirtualAppliance" ? route.value.next_hop_in_ip_address : null
    }
  }
}

########
## Route
########

resource "azurerm_route" "this" {
  for_each               = { for route in var.gateway_routes : route.name => route }
  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.this.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_type == "VirtualAppliance" ? each.value.next_hop_in_ip_address : null
}

##########################
## Route Table Association
##########################

resource "azurerm_subnet_route_table_association" "this" {
  for_each       = toset(var.subnet_ids)
  subnet_id      = each.value
  route_table_id = azurerm_route_table.this.id
}

