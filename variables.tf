variable "subscription_id" {
  description = "Azure subscription ID used for deployment"
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-nationwall-project3"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "South Africa North"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "vnet-nationwall-project3"
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.30.0.0/16"]
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "snet-application"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = string
  default     = "10.30.1.0/24"
}

variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}