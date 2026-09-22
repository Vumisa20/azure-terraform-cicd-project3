terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    use_cli              = true
    use_azuread_auth     = true
    subscription_id      = "b2137b98-8067-4d97-ab44-4ee3fc0b4b1e"
    resource_group_name  = "rg-nationwall-project3"
    storage_account_name = "nwproject3tf20260921"
    container_name       = "tfstate"
    key                  = "nationwall-project3.tfstate"
  }
}
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "nationwall" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Project     = "NationWall-Project3"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_virtual_network" "nationwall" {
  name                = var.vnet_name
  location            = azurerm_resource_group.nationwall.location
  resource_group_name = azurerm_resource_group.nationwall.name
  address_space       = var.vnet_address_space

  tags = {
    Project     = "NationWall-Project3"
    Environment = var.environment
  }
}

resource "azurerm_subnet" "application" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.nationwall.name
  virtual_network_name = azurerm_virtual_network.nationwall.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_network_security_group" "application" {
  name                = "nsg-nationwall-project3"
  location            = azurerm_resource_group.nationwall.location
  resource_group_name = azurerm_resource_group.nationwall.name

  tags = {
    Project     = "NationWall-Project3"
    Environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "application" {
  subnet_id                 = azurerm_subnet.application.id
  network_security_group_id = azurerm_network_security_group.application.id
}

resource "azurerm_storage_account" "nationwall" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.nationwall.name
  location                 = azurerm_resource_group.nationwall.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = {
    Project     = "NationWall-Project3"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}