location = "centralindia"
resource_group = "KeyVault-Test"
keyvault_name = "rsk-test-kv-1"
certificate_name = "app-cert"

app_display_name = "kv-app-registration"

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

subnet_id = "/subscriptions/5649c1ab-1980-41e5-b987-98fb878960ee/resourceGroups/KeyVault-Test/providers/Microsoft.Network/virtualNetworks/kv-vnet-vault/subnets/default"
private_dns_zone_id = "/subscriptions/5649c1ab-1980-41e5-b987-98fb878960ee/resourceGroups/keyvault-test/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"