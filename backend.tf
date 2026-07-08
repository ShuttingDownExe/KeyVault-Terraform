terraform {
  backend "azurerm" {
    resource_group_name = "GAVL-KeyVault-State-RG"
    storage_account_name = "gavlkvstatesa"
    container_name = "gavlterraformstatefile"
    key = "default-kv.tfstate"
  }
}