module "keyvault" {

  source = "./modules/keyvault"

  keyvault_name   = var.keyvault_name
  resource_group  = var.resource_group
  location        = var.location
  certificate_name = var.certificate_name
}

module "identity" {

  source = "./modules/identity"

  app_name              = var.app_name
  keyvault_id           = module.keyvault.keyvault_id
  certificate_data      = module.keyvault.certificate_data
  certificate_end_date  = module.keyvault.certificate_end_date

  kv_admins            = var.kv_admins
  kv_secret_officers   = var.kv_secrets_officers
}