###############################
# Azure Managed Identity Module
###############################

resource "azurerm_user_assigned_identity" "example" {
  name                = var.manaaged_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags         = merge({ "Name" = format("%s", var.manaaged_identity_name) }, var.tags)

}

