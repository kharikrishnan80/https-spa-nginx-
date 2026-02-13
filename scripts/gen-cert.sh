#!/usr/bin/env bash
set -euo pipefail

CERT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../nginx/certs" && pwd)"
CRT="${CERT_DIR}/spa.crt"
KEY="${CERT_DIR}/spa.key"

# Use env var if provided, else fallback
CN="${CN:-myspa.local}"

mkdir -p "${CERT_DIR}"

echo "Generating self-signed cert..."
echo "  CN = ${CN}"
openssl req -x509 -nodes -newkey rsa:2048 \
  -keyout "${KEY}" \
  -out "${CRT}" \
  -days 365 \
  -subj "/C=GB/ST=London/L=London/O=Demo/OU=IT/CN=${CN}"

chmod 600 "${KEY}"
chmod 644 "${CRT}"

echo "Done:"
ls -l "${CRT}" "${KEY}"
