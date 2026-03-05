output "certificate_data_base64" {
  value = azurerm_key_vault_certificate.cert.certificate_data_base64
}

output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}

output "certificate_end_date" {
  value = data.azurerm_key_vault_certificate.current.end_date
}

output "certificate_secret_id" {
  value = data.azurerm_key_vault_certificate.current.secret_id
}