output "resource_group_name" {
  description = "Name of the NationWall resource group"
  value       = azurerm_resource_group.nationwall.name
}

output "virtual_network_name" {
  description = "Name of the NationWall virtual network"
  value       = azurerm_virtual_network.nationwall.name
}

output "subnet_id" {
  description = "ID of the application subnet"
  value       = azurerm_subnet.application.id
}

output "storage_account_name" {
  description = "Name of the NationWall storage account"
  value       = azurerm_storage_account.nationwall.name
}