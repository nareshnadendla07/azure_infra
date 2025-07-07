module "vnet" {
  source = "../network/virtual-network"

  vnet_name                     = var.vnet_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  create_resource_group         = var.create_resource_group
  address_prefixes              = var.address_prefixes
  dns_servers                   = var.dns_servers
  tags                          = var.tags
  subnets                       = var.subnets
  create_ddos_plan              = var.create_ddos_plan
  ddos_plan_name                = var.ddos_plan_name
  create_network_watcher        = var.create_network_watcher
  log_analytics_workspace_id    = var.log_analytics_workspace_id
  storage_account_id            = var.storage_account_id
}
