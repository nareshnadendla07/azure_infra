output "waf_policy_id" {
  description = "The ID of the WAF policy."
  value       = azurerm_web_application_firewall_policy.this.id
}

output "waf_policy_name" {
  description = "The name of the WAF policy."
  value       = azurerm_web_application_firewall_policy.this.name
}

output "waf_policy_resource_group" {
  description = "The resource group of the WAF policy."
  value       = azurerm_web_application_firewall_policy.this.resource_group_name
}
output "waf_policy_location" {
  description = "The location of the WAF policy."
  value       = azurerm_web_application_firewall_policy.this.location
}