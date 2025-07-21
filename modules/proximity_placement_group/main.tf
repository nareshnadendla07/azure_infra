##################################################################################################
# Proximity placement group for virtual machines, virtual machine scale sets and availability sets.
##################################################################################################

resource "azurerm_proximity_placement_group" "appgrp" {
  count               = var.enable_proximity_placement_group ? 1 : 0
  name                = var.proximity_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge({ "ResourceName" = var.proximity_name }, var.tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}