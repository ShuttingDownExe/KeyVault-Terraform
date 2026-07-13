location         = "centralindia"
resource_group   = "GAVL-PROD-RG01"
keyvault_name    = "GAVL-TST-KV"
certificate_name = "gavl-tst-key"

app_display_name = "gavl-tst-ar"

#PLEASE MODIFY THESE VALUES WITH THE OBJECT IDs OF USERS AND SERVICE PRINCIPALS

kv_admins = [
  "05b35071-0e61-4116-b1c9-0560d81084fa"
]

kv_secrets_officers = [
  "05b35071-0e61-4116-b1c9-0560d81084fa"
]

kv_secrets_readers = [
  "05660569-d1d3-4a95-b415-9f6bc47d7bab"
]

kv_certificate_officers = [
  "05b35071-0e61-4116-b1c9-0560d81084fa"
]

subnet_id           = "/subscriptions/e7bd1f53-bd3f-43ba-af71-fb9e45ee8450/resourceGroups/GAVL-PROD-RG01/providers/Microsoft.Network/virtualNetworks/GAVL-DC-VNET/subnets/default"
private_dns_zone_id = "/subscriptions/e7bd1f53-bd3f-43ba-af71-fb9e45ee8450/resourceGroups/gavl-prod-rg01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"