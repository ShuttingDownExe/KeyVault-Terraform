location = "centralindia"
resource_group = "GAVL-DevOps-Tesing-RG"
keyvault_name = "gavl-rsk-test-kv-1"
certificate_name = "test-app-cert"

app_name = "test-app"

#PLEASE MODIFY THESE VALUES WITH THE OBJECT IDs OF USERS AND SERVICE PRINCIPALS

kv_admins = [
  "b7462be6-5cf8-4c60-bd0d-820839012cc1",
  "<Object ID of another user or service principal>"
]

kv_secrets_officers = [
  "b7462be6-5cf8-4c60-bd0d-820839012cc1",
  "<Object ID of another user or service principal>"
]

kv_secrets_readers = [ 
  "b7462be6-5cf8-4c60-bd0d-820839012cc1",
  "<Object ID of another user or service principal>"
]

subnet_id = "/subscriptions/84f32968-136c-4b1c-89f3-953cf9f787a9/resourceGroups/GAVL-PROD-RG01/providers/Microsoft.Network/virtualNetworks/<VNET_NAME>/subnets/<SUBNET_NAME>"
private_dns_zone_id = "/subscriptions/84f32968-136c-4b1c-89f3-953cf9f787a9/resourceGroups/GAVL-PROD-RG01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"