data "azurerm_client_config" "current" {}
data "azurerm_key_vault_certificate" "current" {
  name = azurerm_key_vault_certificate.cert.name
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault" "kv" {
  name = var.keyvault_name
  location = var.location
  resource_group_name = var.resource_group
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "premium"
  purge_protection_enabled = true
  soft_delete_retention_days = 90
  public_network_access_enabled = false
  enable_rbac_authorization = true
  
}

resource "azurerm_role_assignment" "current_principal_cert_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "${var.keyvault_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.keyvault_name}-psc"
    is_manual_connection            = false
    private_connection_resource_id   = azurerm_key_vault.kv.id
    subresource_names                = ["vault"]
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_id == null ? [] : [var.private_dns_zone_id]
    content {
      name                 = "default"
      private_dns_zone_ids = [private_dns_zone_group.value]
    }
  }
}

resource "azurerm_key_vault_certificate" "cert" {
  name = var.certificate_name
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [azurerm_role_assignment.current_principal_cert_officer]

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
    lifetime_action {
      action {action_type = "AutoRenew"}
      trigger {days_before_expiry = 30}
    }
  }
}