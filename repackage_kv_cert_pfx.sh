#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./repackage_kv_cert_pfx.sh <vault_name> <certificate_name> <password_secret_name> [output_pfx]

Example:
  ./repackage_kv_cert_pfx.sh rsk-test-kv-9 app-cert-9 cert-password app-cert-9-protected.pfx

Notes:
- The Key Vault certificate secret is downloaded as base64 and decoded to a PFX.
- The source PFX is assumed to have a blank password by default.
- To use a non-blank source PFX password, set SOURCE_PFX_PASSWORD in the environment.
USAGE
}

if [[ $# -lt 3 || $# -gt 4 ]]; then
  usage
  exit 1
fi

VAULT_NAME="$1"
CERT_NAME="$2"
PASSWORD_SECRET_NAME="$3"
OUTPUT_PFX="${4:-${CERT_NAME}-protected.pfx}"

for cmd in az openssl mktemp; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command not found: $cmd" >&2
    exit 1
  fi
done

TMP_DIR="$(mktemp -d)"
TMP_PFX="$TMP_DIR/source.pfx"
TMP_PEM="$TMP_DIR/bundle.pem"

cleanup() {
  rm -f "$TMP_PFX" "$TMP_PEM"
  rmdir "$TMP_DIR" 2>/dev/null || true
}
trap cleanup EXIT

echo "Reading target password from Key Vault secret..."
TARGET_PASSWORD="$(az keyvault secret show \
  --vault-name "$VAULT_NAME" \
  --name "$PASSWORD_SECRET_NAME" \
  --query value -o tsv)"

if [[ -z "$TARGET_PASSWORD" ]]; then
  echo "Error: password secret is empty." >&2
  exit 1
fi

echo "Downloading certificate secret and decoding to PFX..."
az keyvault secret download \
  --vault-name "$VAULT_NAME" \
  --name "$CERT_NAME" \
  --encoding base64 \
  --file "$TMP_PFX" \
  --only-show-errors

if [[ ! -s "$TMP_PFX" ]]; then
  echo "Error: downloaded PFX is empty." >&2
  exit 1
fi

SOURCE_PFX_PASSWORD="${SOURCE_PFX_PASSWORD:-}"

echo "Extracting certificate and key from source PFX..."
openssl pkcs12 \
  -in "$TMP_PFX" \
  -passin "pass:${SOURCE_PFX_PASSWORD}" \
  -nodes \
  -out "$TMP_PEM" \
  >/dev/null 2>&1

echo "Re-exporting PFX with target password..."
openssl pkcs12 \
  -export \
  -in "$TMP_PEM" \
  -out "$OUTPUT_PFX" \
  -passout "pass:${TARGET_PASSWORD}" \
  >/dev/null 2>&1

chmod 600 "$OUTPUT_PFX" || true

echo "Verifying output PFX..."
openssl pkcs12 \
  -in "$OUTPUT_PFX" \
  -info \
  -noout \
  -passin "pass:${TARGET_PASSWORD}" \
  >/dev/null

echo "Done. Password-protected PFX created: $OUTPUT_PFX"
