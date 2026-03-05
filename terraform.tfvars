location = "centralindia"
resource_group = "GAVL-DevOps-Tesing-RG"
keyvault_name = "gavl-rsk-test-kv-1"
certificate_name = "test-app-cert"

app_name = "test-app"

#PLEASE MODIFY THESE VALUES WITH THE OBJECT IDs OF USERS AND SERVICE PRINCIPALS

kv_admins = [
  "11111111-aaaa-bbbb-cccc-111111111111"
]

kv_secrets_officers = [
  "22222222-aaaa-bbbb-cccc-222222222222"
]

kv_secrets_readers = [ 
  "22222222-aaaa-bbbb-cccc-222222222222" 
]