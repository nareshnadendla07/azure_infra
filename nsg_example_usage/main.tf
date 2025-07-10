module "nsg" {
  source              = "../modules/network/nsg"
  nsg_name            = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  rules = [
    {
      name                       = "rdp-in-allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = 210
      direction                  = "Inbound"
    },
    {
      name                       = "smb-out-allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = 220
      direction                  = "Outbound"
    }
  ]
  subnet_id                  = module.vnet.subnet_ids[var.subnet_name]
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = module.storage_account.storage_account_id

  depends_on = [module.vnet]

}
