output "app_client_id" {
  value = azuread_application.app.client_id
}

output "app_object_id" {
  value = azuread_application.app.object_id
}

output "service_principal_object_id" {
  value = azuread_service_principal.sp.object_id
}
