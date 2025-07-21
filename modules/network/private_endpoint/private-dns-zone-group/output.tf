output "dns__zone_group_name" {
  description = "The name of the private endpoint DNS zone group."
  value       = azurerm_private_dns_zone_group.this.name
}

output "resource_id" {
  description = "The resource ID of the private endpoint DNS zone group."
  value       = azurerm_private_dns_zone_group.this.id
}
