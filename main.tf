provider "azurerm" {
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "storageResourceGroup"
    storage_account_name = "terrastorageacc"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "West Europe"
}

resource "azurerm_container_group" "tfcontainer" {
  name = "weatherapi"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "sindikat1984"
  os_type = "Linux"
  container {
    name = "weatherapi"
    image = "sindikat1984/weatherapi"
    cpu = "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
}