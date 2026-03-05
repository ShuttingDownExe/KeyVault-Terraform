# Azure Key Vault Certificate Architecture (Terraform)

This Terraform project builds a certificate-based identity pattern on Azure using Key Vault and Entra ID.

## Architecture Summary

The deployment has two core building blocks:

1. `Key Vault Layer`
   - Creates an Azure Key Vault (RBAC-based authorization).
   - Generates and stores a self-signed certificate in the vault.
2. `Identity Layer`
   - Creates an Entra application registration and service principal.
   - Binds the Key Vault certificate to the app registration as a credential.
   - Assigns Key Vault RBAC roles to app/service principal and admin user groups.

## Logical Flow

1. Terraform creates Key Vault.
2. Terraform grants temporary admin rights to the deployment identity.
3. Terraform creates a certificate in Key Vault.
4. Certificate metadata is passed into the identity module.
5. Terraform creates app registration + service principal.
6. Terraform attaches the certificate to the app registration.
7. Terraform assigns Key Vault roles for operational access.

## Component Interaction

- `modules/keyvault` outputs `keyvault_id`, certificate data, and certificate end date.
- `modules/identity` consumes those outputs to configure app certificate auth and vault permissions.
- Root module orchestrates the two modules and exposes tenant-level output.

## Current Network Posture

- Key Vault is currently reachable via public network access.
- Authorization model is Azure RBAC (`enable_rbac_authorization = true`).

## What Is Missing (Next Steps)

To match the target design (private Key Vault access via certificate-authenticated app registration), add the following:

1. Enforce private-only Key Vault access.
   - Set `public_network_access_enabled = false` on the Key Vault.
   - Add/confirm network ACLs with default deny posture.
2. Add a Key Vault private endpoint architecture.
   - Create private endpoint in an application subnet.
   - Add required VNet/subnet inputs to Terraform.
3. Add private DNS for Key Vault private link.
   - Create/link `privatelink.vaultcore.azure.net` private DNS zone.
   - Add private DNS zone group on the private endpoint.
4. Ensure workload connectivity path is private.
   - App host (VM/AKS/App Service integration) must resolve and reach Key Vault over private network.
5. Lock RBAC to app-only secret read pattern.
   - Keep app/service principal on secret-read role (`Key Vault Secrets User`, equivalent to secrets-reader behavior).
   - Remove non-essential human/admin data-plane roles from steady state.
6. Fix current module wiring gap.
   - Pass `kv_secrets_readers` from root `main.tf` into `module "identity"`.
7. Add validation and operational checks.
   - Validate public endpoint is blocked.
   - Validate app can fetch secrets using certificate auth.
   - Validate non-approved identities are denied.

## Required Inputs (High Level)

- Azure location and resource group
- Key Vault name and certificate name
- Application display name
- Object IDs for RBAC groups/users:
  - Key Vault Administrators
  - Key Vault Secrets Officers
  - Key Vault Secrets Readers

## Deployment

```bash
terraform init
terraform plan
terraform apply
```

Get the certificate using Azure CLI:

```powershell
az keyvault secret download \
   --vault-name <Vault Name> \
   --name <Secret Name> \
   --file cert.pfx
```

## Notes

- Replace placeholder object IDs in `terraform.tfvars` before deployment.
- Keep least-privilege RBAC assignments.