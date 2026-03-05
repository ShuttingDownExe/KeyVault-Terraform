variable "kv_admins" {
    type = list(string)
}

variable "kv_secrets_officers" {
    type = list(string)
}

variable "kv_secrets_readers" {
    type = list(string)
}

variable "location" {}
variable "resource_group" {}
variable "keyvault_name" {}
variable "certificate_name" {}
variable "app_name" {}