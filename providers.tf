terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.100"
    }

    azuread = {
        source = "hashicorp/azuread"
        version = "~>2.50"
    }

    time = {
        source = "hashicorp/time"
        version = "~>0.11"
    }
  }
}

provider "azurerm" {
  features {}
}

# provider "azuread" {}

data "azurerm_client_config" "current" {}