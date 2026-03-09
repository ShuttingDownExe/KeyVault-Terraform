
resource "azuread_application" "app" {
  display_name = var.app_name
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}

resource "azuread_application_certificate" "cert" {

  application_id = azuread_application.app.client_id
  type = "AsymmetricX509Cert"
  value    = var.certificate_data
  end_date = var.certificate_end_date
}

resource "azurerm_role_assignment" "app_kv_access" {

  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_service_principal.sp.object_id
}

resource "azurerm_role_assignment" "kv_admins" {

  for_each = toset(var.kv_admins)

  scope                = var.keyvault_id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "kv_secret_officers" {

  for_each = toset(var.kv_secrets_officers)

  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "kv_secret_readers" {

  for_each = toset(var.kv_secrets_readers)

  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value
}