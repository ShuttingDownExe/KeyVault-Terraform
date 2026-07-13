location         = "centralindia"
resource_group   = "GAVL-PROD-RG01"
keyvault_name    = "GAVL-A136-DHR-KV"
certificate_name = "gavl-a136-dhr-key"

app_display_name = "gavl-a136-dhr-ar"

#PLEASE MODIFY THESE VALUES WITH THE OBJECT IDs OF USERS AND SERVICE PRINCIPALS

kv_admins = [
  "334ba4fc-19d3-4c8a-b09d-2dad96557e24",
  "b7462be6-5cf8-4c60-bd0d-820839012cc1"
]

kv_secrets_officers = [
  "0f0d4f84-afdc-4096-8f01-c71b99f0cccc",
  "b7462be6-5cf8-4c60-bd0d-820839012cc1"
]

kv_secrets_readers = [
  "05660569-d1d3-4a95-b415-9f6bc47d7bab"
]

kv_certificate_officers = [
  "b7462be6-5cf8-4c60-bd0d-820839012cc1"
]

subnet_id           = "/subscriptions/84f32968-136c-4b1c-89f3-953cf9f787a9/resourceGroups/GAVL-DC-RG01/providers/Microsoft.Network/virtualNetworks/GAVL-DC-VNET/subnets/default"
private_dns_zone_id = "/subscriptions/b4b4b6b6-2e4f-40d7-bbae-b1d631a68953/resourceGroups/Hub_DNS-RG/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"