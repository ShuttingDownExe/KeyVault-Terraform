# Azure Key Vault Certificate Architecture (Terraform)

This project deploys a private-access Azure Key Vault and configures certificate-based authentication for a newly created Entra application.

## What This Deploys

### Key Vault module (`modules/keyvault`)

1. Azure Key Vault with:
   - RBAC authorization enabled
   - public access disabled (`public_network_access_enabled = false`)
   - purge protection and soft delete enabled
2. Private endpoint for Key Vault in the subnet provided by `subnet_id`.
3. Private DNS zone group attachment using `private_dns_zone_id`.
4. Self-signed Key Vault certificate (`certificate_name`).
5. Role assignment to the Terraform execution principal:
   - `Key Vault Certificates Officer` on the vault
   - used so Terraform can create/read certificate objects during apply.

### Identity module (`modules/identity`)

1. Entra application registration (created from `app_display_name`).
2. Entra service principal for the application.
3. Application certificate credential using certificate material from Key Vault.
4. Key Vault RBAC assignments:
   - app/service principal: `Key Vault Secrets User`
   - `kv_admins`: `Key Vault Administrator`
   - `kv_secrets_officers`: `Key Vault Secrets Officer`
   - `kv_secrets_readers`: `Key Vault Secrets User`
   - `kv_certificate_officers`: `Key Vault Certificates Officer`

## End-to-End Flow

1. Create Key Vault (private-only).
2. Assign certificate officer role to the Terraform caller.
3. Create Key Vault private endpoint and attach DNS zone group.
4. Create self-signed certificate in Key Vault.
5. Create Entra app registration and service principal.
6. Attach Key Vault certificate to the app registration.
7. Apply Key Vault RBAC assignments.

## Current Network Posture

- Key Vault is private-only (`public_network_access_enabled = false`).
- Private endpoint is required and is created by Terraform.
- Private DNS zone is expected to already exist and is linked through the private endpoint zone group.

## Prerequisites (Must Exist Before Apply)

1. Target resource group.
2. A non-delegated subnet for the Key Vault private endpoint (`subnet_id`).
3. Private DNS zone `privatelink.vaultcore.azure.net` (`private_dns_zone_id`).
4. DNS link(s) so workloads can resolve Key Vault private DNS (typically at least to the app VNet).
5. If app and vault are in separate VNets: bidirectional VNet peering and required NSG/UDR/firewall allow rules.

## Execution Requirements

Because Key Vault public access is disabled, Terraform must run from a network path that can reach the private endpoint.

Use one of the following:

1. VM in the VNet (or peered VNet), accessed via Bastion.
2. VPN-connected machine into that VNet path.
3. Self-hosted CI runner in that VNet.

Running from public-only environments (for example, GitHub-hosted runners or Cloud Shell without private routing) can fail with `ForbiddenByConnection` during certificate operations.

## Permissions and Provider Notes

1. `azurerm` provider uses `skip_provider_registration = true`, so required resource providers must already be registered in the subscription.
   - At minimum: `Microsoft.KeyVault`, `Microsoft.Network`, `Microsoft.Authorization`.
2. The Terraform identity needs:
   - infrastructure write permissions on target scope
   - rights to create role assignments
   - Entra permissions to create application registrations/service principals.

## Inputs (Root Module)

- `location`
- `resource_group`
- `keyvault_name`
- `certificate_name`
- `app_display_name`
- `subnet_id`
- `private_dns_zone_id`
- `kv_admins` (list of object IDs)
- `kv_secrets_officers` (list of object IDs)
- `kv_secrets_readers` (list of object IDs)
- `kv_certificate_officers` (list of object IDs)

All object ID and resource ID input formats are validated in Terraform.

## Outputs

Root outputs include:

- `tenant_id`
- `app_client_id`
- `app_object_id`
- `service_principal_object_id`

## Deployment

```bash
terraform init
terraform workspace select test || terraform workspace new test
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Post-Deploy Validation

From an app-side host with private connectivity:

```bash
nslookup <vault-name>.vault.azure.net
```

Expected: resolution to a private IP from the private endpoint path.

## Download Certificate Secret

```powershell
az keyvault secret download \
  --vault-name <vault-name> \
  --name <certificate-name> \
  --file cert.pfx
```

## Troubleshooting Quick Notes

1. `InvalidAuthenticationTokenTenant`:
   - Azure CLI is logged into a tenant/subscription different from the target subscription.
2. `MissingSubscriptionRegistration`:
   - required resource provider is not registered.
3. `ForbiddenByConnection` on certificate operations:
   - Terraform execution host does not have private network path to the Key Vault private endpoint.