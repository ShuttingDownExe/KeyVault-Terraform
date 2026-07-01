output "certificate_data_base64" {
  value = azurerm_key_vault_certificate.cert.certificate_data_base64
}

output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}

output "certificate_end_date" {
  value = azurerm_key_vault_certificate.cert.certificate_attribute[0].expires
}

output "certificate_secret_id" {
  value = azurerm_key_vault_certificate.cert.secret_id
}

output "certificate_password_secret_uri" {
  value = azurerm_key_vault_secret.cert-password.id
}