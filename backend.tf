terraform {
  backend "azurerm" {
    resource_group_name = " GAVL-KeyVault-State-RG"
    storage_account_name = "gavlkvstate"
    container_name = "CONTAINER NAME"
    key = "<APP>-kv.tfstate"
  }
}
