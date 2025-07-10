module "avd_routeTables" {
  source              = "../modules/network/route-table"
  rtname              = var.rt_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_ids = [
    module.vnet.subnet_ids[var.subnet_name]

  ]

  routes = [
    {
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "" # DNS Server IP
      has_bgp_override       = false
    }
    
  ]
  tags       = var.tags
  depends_on = [module.vnet]

}