location = "centralindia"
resource_group = "GAVL-PROD-RG01"
keyvault_name = "GAVL-A012-TMS-KV"
certificate_name = "gavl-a012-tms-key"

app_display_name = "gavl-a012-tms-ar"

#PLEASE MODIFY THESE VALUES WITH THE OBJECT IDs OF USERS AND SERVICE PRINCIPALS

kv_admins = [
  "0f0d4f84-afdc-4096-8f01-c71b99f0cccc",
  "009438f1-23eb-4cca-80fe-4844900ef1db"
]

kv_secrets_officers = [
  "0f0d4f84-afdc-4096-8f01-c71b99f0cccc",
  "009438f1-23eb-4cca-80fe-4844900ef1db"
]

kv_secrets_readers = [ 
  "0f0d4f84-afdc-4096-8f01-c71b99f0cccc"
]

kv_certificate_officers = [
  "0f0d4f84-afdc-4096-8f01-c71b99f0cccc"
]

subnet_id = "/subscriptions/84f32968-136c-4b1c-89f3-953cf9f787a9/resourceGroups/GAVL-DC-RG01/providers/Microsoft.Network/virtualNetworks/GAVL-DC-VNET/subnets/default"
private_dns_zone_id = "/subscriptions/b4b4b6b6-2e4f-40d7-bbae-b1d631a68953/resourceGroups/Hub_DNS-RG/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"