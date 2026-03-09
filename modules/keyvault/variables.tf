variable "keyvault_name" {}
variable "resource_group" {}
variable "location" {}
variable "certificate_name" {}
variable "subnet_id" {}
variable "private_dns_zone_id" {
    default = null
}