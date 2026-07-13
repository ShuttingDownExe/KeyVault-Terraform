variable "app_display_name" {
  type = string

  validation {
    condition     = length(trimspace(var.app_display_name)) > 0
    error_message = "app_display_name must be a non-empty string."
  }
}
variable "certificate_data" {}
variable "certificate_end_date" {}
variable "keyvault_id" {}
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

variable "kv_certificate_officers" {
  type = list(string)
  validation {
    condition = alltrue([
      for id in var.kv_certificate_officers : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))
    ])
    error_message = "kv_certificate_officers must contain only valid Entra object IDs (UUID format)."
  }
}

