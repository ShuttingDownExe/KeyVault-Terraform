variable "kv_admins" {
    type = list(string)

    validation {
        condition = alltrue([
            for id in var.kv_admins : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))
        ])
        error_message = "kv_admins must contain only valid Entra object IDs (UUID format)."
    }
}

variable "kv_secrets_officers" {
    type = list(string)

    validation {
        condition = alltrue([
            for id in var.kv_secrets_officers : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))
        ])
        error_message = "kv_secrets_officers must contain only valid Entra object IDs (UUID format)."
    }
}

variable "kv_secrets_readers" {
    type = list(string)

    validation {
        condition = alltrue([
            for id in var.kv_secrets_readers : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))
        ])
        error_message = "kv_secrets_readers must contain only valid Entra object IDs (UUID format)."
    }
}

variable "kv_certificate_officers"{
    type = list(string)
     validation {
        condition = alltrue([
            for id in var.kv_certificate_officers : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))
        ])
        error_message = "kv_secrets_readers must contain only valid Entra object IDs (UUID format)."
    }
}

variable "location" {}
variable "resource_group" {}
variable "keyvault_name" {}
variable "certificate_name" {}
variable "app_client_id" {
    type = string

    validation {
        condition = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.app_client_id))
        error_message = "app_client_id must be a valid application (client) ID in UUID format."
    }
}
variable "subnet_id" {
    type = string

    validation {
        condition = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/[^/]+$", var.subnet_id))
        error_message = "subnet_id must be a full Azure subnet resource ID."
    }
}
variable "private_dns_zone_id" {
    type = string

    validation {
        condition = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/privateDnsZones/privatelink\\.vaultcore\\.azure\\.net$", var.private_dns_zone_id))
        error_message = "private_dns_zone_id must be a full resource ID for privatelink.vaultcore.azure.net."
    }
}