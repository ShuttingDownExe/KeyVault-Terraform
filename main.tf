module "keyvault" {
  source = "./modules/keyvault"

  keyvault_name       = var.keyvault_name
  resource_group      = var.resource_group
  location            = var.location
  certificate_name    = var.certificate_name
  subnet_id           = var.subnet_id
  private_dns_zone_id = var.private_dns_zone_id
}

module "identity" {

  source = "./modules/identity"

  app_display_name     = var.app_display_name
  keyvault_id          = module.keyvault.keyvault_id
  certificate_data     = module.keyvault.certificate_data_base64
  certificate_end_date = module.keyvault.certificate_end_date

  kv_admins               = var.kv_admins
  kv_secrets_officers     = var.kv_secrets_officers
  kv_secrets_readers      = var.kv_secrets_readers
  kv_certificate_officers = var.kv_certificate_officers
}