data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name = var.keyvault_name
  location = var.location
  resource_group_name = var.resource_group
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "premium"
  purge_protection_enabled = true
  #soft_delete_retention_days = 90
  public_network_access_enabled = true #REPLACE THIS WITH PRIVATE ENDPOINT
  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "kv_admin" {
  scope = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id = data.azurerm_client_config.current.object_id
  principal_type = "User"
}

resource "azurerm_key_vault_certificate" "cert" {
  name = var.certificate_name
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [ azurerm_role_assignment.kv_admin ]

  certificate_policy {
    issuer_parameters {
        name = "Self"
    }
    key_properties {
        exportable = true
        key_size = 4096
        key_type = "RSA"
        reuse_key = true
    }
    secret_properties {
        content_type = "application/x-pkcs12"
    }
    x509_certificate_properties {
      subject = "CN=${var.certificate_name}"
      validity_in_months = 12
      key_usage = ["digitalSignature","keyEncipherment"]
      extended_key_usage = [ "1.3.6.1.5.5.7.3.2" ]
    }
  }
}