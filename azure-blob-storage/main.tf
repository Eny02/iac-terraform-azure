variable "resource_group_name" {
  type    = string
  default = "MojaGrupa"
}

variable "storage_account_name" {
  type    = string
  default = "MojStorage"
}

variable "container_name" {
  type    = string
  default = "MojKontener"
}

variable "blob_name" {
  type    = string
  default = "MojBlob"
}

resource "azurerm_resource_group" "przykladResource" {
  name     = var.resource_group_name
  location = "Central Europe"
}

resource "azurerm_storage_account" "przykladStorage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "przykladStorage" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "przykladBlob" {
  name                   = var.blob_name
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "path/to/local/file.txt"
}

