output "subnet_ids" {
  value = { for k, v in azurerm_subnet.snet : k => v.id }
  description = "Map of subnet names to their respective IDs."
}

output "subnets" {
  value = {
    for s in azurerm_subnet.snet : s.name => {
      id   = s.id,
      name = s.name
    }
  }
  description = "A map of subnet names to detailed maps including IDs."
}
