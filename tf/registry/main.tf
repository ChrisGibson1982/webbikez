variable "prefix" {
  type        = string
}

provider "azurerm" {
    version = "~> 2.60.0"
    features {}
}

terraform {
  backend "azurerm" {}
}


data "azurerm_client_config" "current" {}

# Create ACR
 resource "azurerm_resource_group" "rg" {
   name     = "${var.prefix}rg002"
   location = "northeurope"
 }

 resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr001"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false

}

# # Create an App Service Plan with Linux
# resource "azurerm_app_service_plan" "asp" {
#   name                = "${azurerm_resource_group.rg.name}-plan"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"

#   # Define Linux as Host OS
#   kind = "Linux"

#   # Choose size
#   sku {
#     tier = "Free"
#     size = "F1"
#   }

#   properties {
#     reserved = true # Mandatory for Linux plans
#   }
# }

# # Create an Azure Web App for Containers in that App Service Plan
# resource "azurerm_app_service" "dockerapp" {
#   name                = "${azurerm_resource_group.rg.name}-dockerapp"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   app_service_plan_id = "${azurerm_app_service_plan.asp.id}"

#   # Do not attach Storage by default
#   app_settings {
#     WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

#     /*
#     # Settings for private Container Registires  
#     DOCKER_REGISTRY_SERVER_URL      = ""
#     DOCKER_REGISTRY_SERVER_USERNAME = ""
#     DOCKER_REGISTRY_SERVER_PASSWORD = ""
#     */
#   }

#   # Configure Docker Image to load on start
#   site_config {
#     linux_fx_version = "DOCKER|appsvcsample/static-site:latest"
#     always_on        = "true"
#   }

#   identity {
#     type = "SystemAssigned"
#   }
# }