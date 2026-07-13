variable "keyvault_name" {}
variable "resource_group" {}
variable "location" {}
variable "certificate_name" {}
variable "subnet_id" {
  type = string

  validation {
    condition     = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/[^/]+$", var.subnet_id))
    error_message = "subnet_id must be a full Azure subnet resource ID."
  }
}
variable "private_dns_zone_id" {
  type = string

  validation {
    condition     = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/privateDnsZones/privatelink\\.vaultcore\\.azure\\.net$", var.private_dns_zone_id))
    error_message = "private_dns_zone_id must be a full resource ID for privatelink.vaultcore.azure.net."
  }
}

variable "private_endpoint_propagation_wait_seconds" {
  type    = number
  default = 120

  validation {
    condition     = var.private_endpoint_propagation_wait_seconds >= 0 && var.private_endpoint_propagation_wait_seconds <= 900
    error_message = "private_endpoint_propagation_wait_seconds must be between 0 and 900."
  }
}