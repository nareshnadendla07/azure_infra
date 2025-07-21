###################################################
# Manages an Availability Set for Virtual Machines.
###################################################

resource "azurerm_availability_set" "this" {  
  name                         = var.availability_set_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  proximity_placement_group_id = var.proximity_placement_group_id
  managed                      = true
  tags                         = merge({ "ResourceName" = var.availability_set_name }, var.tags)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}



