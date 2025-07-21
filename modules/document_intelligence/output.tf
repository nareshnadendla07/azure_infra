output "document_intelligence_endpoint" {
  value = azurerm_cognitive_account.this.endpoint
}

output "document_intelligence_key" {
  value     = azurerm_cognitive_account.this.primary_access_key
  sensitive = true
}

output "document_intelligence_id" {
  value = azurerm_cognitive_account.this.id
}