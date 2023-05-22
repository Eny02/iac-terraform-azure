resource "azurerm_resource_group" "przykład1ResourceGroup" {
  name     = "przykład1ResourceGroup"
  location = "Central Europe"
}

data "azurerm_storage_account" "przyklad2StorageAccount" {
  name                = "przyklad2StorageAccount"
  resource_group_name = "przyklad2Storage"
}

output "storage_account_tier" {
  value = data.przyklad2StorageAccount.example.account_tier
}

resource "azurerm_service_plan" "przyklad3ServicePlan" {
  name                = "przyklad3ServicePlan"
  resource_group_name = przykład1ResourceGroup.example.name
  location            = przykład1ResourceGroup.example.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_function_app" "przyklad4LinuxApp" {
  name                = "przyklad4LinuxApp"
  resource_group_name = przykład1ResourceGroup.example.name
  location            = przykład1ResourceGroup.example.location

  storage_account_name       = przyklad2StorageAccount.example.name
  storage_account_access_key = przyklad2StorageAccount.example.primary_access_key
  service_plan_id            = przyklad3ServicePlan.example.id

  site_config {}
}

resource "azurerm_function_app" "przyklad5FunctionApp" {
  name                       = "przyklad5FunctionApp"
  location                   = przykład1ResourceGroup.example.location
  resource_group_name        = przykład1ResourceGroup.example.name
  app_service_plan_id        = przyklad3ServicePlan.example.id
  storage_account_name       = przyklad2StorageAccount.example.name
  storage_account_access_key = przyklad2StorageAccount.example.primary_access_key
}
