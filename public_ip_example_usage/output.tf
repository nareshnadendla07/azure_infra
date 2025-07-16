output "public_ip_id" {
  value       = azurerm_public_ip.this.id
  description = "ID of the Public IP"
}

output "public_ip_address" {
  value       = azurerm_public_ip.this.ip_address
  description = "Actual IP address allocated"
}

output "public_ip_fqdn" {
  value       = try(azurerm_public_ip.this.fqdn, null)
  description = "Fully Qualified Domain Name (if DNS settings are enabled)"
}
