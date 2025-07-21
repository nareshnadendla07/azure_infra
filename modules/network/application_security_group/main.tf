####################################
## Application Security Group Module
####################################

resource "azurerm_application_security_group" "asg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

 tags     = merge({ "Name" = format("%s", var.name) }, var.tags, )
}

#########################################
## Application Security Group Association
#########################################

resource "azurerm_network_interface_application_security_group_association" "example" {
  network_interface_id          = var.network_interface_id  
  application_security_group_id = azurerm_application_security_group.asg.id
}
