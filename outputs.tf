output "app_client_id" {
  value = module.identity.app_client_id
}

output "app_object_id" {
  value = module.identity.app_object_id
}

output "service_principal_object_id" {
  value = module.identity.service_principal_object_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}