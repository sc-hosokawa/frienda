#!/usr/bin/env bash
#
# Cloud SQL pg_dump スクリプト
#
# Cloud SQL インスタンスからデータベースをエクスポートする。
# 一時的にパブリックIPを割り当て、現在のIPを許可リストに追加し、
# pg_dump 実行後にセキュリティ設定を元に戻す。
#
# 注意: このスクリプトはリポジトリルートから実行してください。
#
# Usage:
#   ./services/postgres/cloud-sql-dump.sh [options]
#
# Options:
#   -i, --instance   Cloud SQL instance name (default: frienda-dev-pg)
#   -d, --database   Database name (default: frienda-pg)
#   -u, --user       Database user (default: frienda-pg)
#   -o, --output     Output file path (default: services/postgres/frienda-pg-dump.sql)
#   -h, --help       Show this help message
#
# Environment variables:
#   PGPASSWORD       Database password (required, or will be prompted)
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---- Defaults ----
INSTANCE="frienda-dev-pg"
DATABASE="frienda-pg"
DB_USER="frienda-pg"
OUTPUT="${SCRIPT_DIR}/frienda-pg-dump.sql"

# ---- Help function ----
show_help() {
  cat <<'HELP'
Cloud SQL pg_dump スクリプト

Usage:
  ./services/postgres/cloud-sql-dump.sh [options]

Options:
  -i, --instance   Cloud SQL instance name (default: frienda-dev-pg)
  -d, --database   Database name (default: frienda-pg)
  -u, --user       Database user (default: frienda-pg)
  -o, --output     Output file path (default: services/postgres/frienda-pg-dump.sql)
  -h, --help       Show this help message

Environment variables:
  PGPASSWORD       Database password (required, or will be prompted)
HELP
}

# ---- Parse arguments ----
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--instance) INSTANCE="$2"; shift 2 ;;
    -d|--database) DATABASE="$2"; shift 2 ;;
    -u|--user)     DB_USER="$2"; shift 2 ;;
    -o|--output)   OUTPUT="$2"; shift 2 ;;
    -h|--help)     show_help; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

# ---- Validate prerequisites ----
for cmd in gcloud pg_dump curl; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is not installed." >&2
    exit 1
  fi
done

if [[ -z "${PGPASSWORD:-}" ]]; then
  echo -n "Enter password for ${DB_USER}@${DATABASE}: "
  read -rs PGPASSWORD
  echo
  export PGPASSWORD
fi

# ---- State tracking for cleanup ----
ORIGINAL_NETWORKS=""
HAD_PUBLIC_IP=false

# ---- Save existing state ----
echo "=== Saving existing Cloud SQL state ==="

# Check if public IP is already assigned
EXISTING_IPS=$(gcloud sql instances describe "$INSTANCE" \
  --format="value(ipAddresses[0].ipAddress)" 2>/dev/null || echo "")
if [[ -n "$EXISTING_IPS" ]]; then
  HAD_PUBLIC_IP=true
  echo "Public IP already assigned: ${EXISTING_IPS}"
fi

# Save existing authorized networks
ORIGINAL_NETWORKS=$(gcloud sql instances describe "$INSTANCE" \
  --format="json(settings.ipConfiguration.authorizedNetworks)" 2>/dev/null \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
networks = data.get('settings', {}).get('ipConfiguration', {}).get('authorizedNetworks') or []
print(','.join(n['value'] for n in networks))
" 2>/dev/null || echo "")

if [[ -n "$ORIGINAL_NETWORKS" ]]; then
  echo "Existing authorized networks: ${ORIGINAL_NETWORKS}"
else
  echo "No existing authorized networks."
fi

# ---- Cleanup function (restore security settings) ----
cleanup() {
  echo ""
  echo "=== Cleaning up ==="

  # Restore authorized networks to original state
  if [[ -n "$ORIGINAL_NETWORKS" ]]; then
    echo "Restoring original authorized networks: ${ORIGINAL_NETWORKS}"
    gcloud sql instances patch "$INSTANCE" \
      --authorized-networks="$ORIGINAL_NETWORKS" --quiet 2>/dev/null || true
  else
    echo "Clearing authorized networks (none existed before)..."
    gcloud sql instances patch "$INSTANCE" \
      --clear-authorized-networks --quiet 2>/dev/null || true
  fi

  # Only disable public IP if it wasn't assigned before
  if [[ "$HAD_PUBLIC_IP" = false ]]; then
    echo "Disabling public IP (was not assigned before)..."
    gcloud sql instances patch "$INSTANCE" --no-assign-ip --quiet 2>/dev/null || true
  else
    echo "Keeping public IP (was already assigned before script execution)."
  fi

  echo "Cleanup complete."
}
trap cleanup EXIT

# ---- Step 1: Assign public IP ----
echo "=== Step 1: Assigning public IP to ${INSTANCE} ==="
gcloud sql instances patch "$INSTANCE" --assign-ip

# ---- Step 2: Get instance public IP (with retry) ----
echo "=== Step 2: Getting instance public IP ==="
INSTANCE_IP=""
for attempt in 1 2 3 4 5; do
  INSTANCE_IP=$(gcloud sql instances describe "$INSTANCE" \
    --format="value(ipAddresses[0].ipAddress)" 2>/dev/null || echo "")
  if [[ -n "$INSTANCE_IP" ]]; then
    break
  fi
  echo "Waiting for public IP assignment... (attempt ${attempt}/5)"
  sleep 5
done

if [[ -z "$INSTANCE_IP" ]]; then
  echo "Error: Could not retrieve instance public IP after 5 attempts." >&2
  exit 1
fi
echo "Instance IP: ${INSTANCE_IP}"

# ---- Step 3: Get current public IP and authorize ----
echo "=== Step 3: Authorizing current IP ==="
MY_IP=""
MY_IP=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null || echo "")
if [[ -z "$MY_IP" ]]; then
  echo "api.ipify.org unavailable, trying ifconfig.me..."
  MY_IP=$(curl -s --max-time 5 https://ifconfig.me 2>/dev/null || echo "")
fi
if [[ -z "$MY_IP" || ! "$MY_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Could not determine public IPv4 address." >&2
  exit 1
fi
echo "My IP: ${MY_IP}"

# Append current IP to existing authorized networks (preserve existing)
if [[ -n "$ORIGINAL_NETWORKS" ]]; then
  NETWORKS="${ORIGINAL_NETWORKS},${MY_IP}/32"
else
  NETWORKS="${MY_IP}/32"
fi
gcloud sql instances patch "$INSTANCE" \
  --authorized-networks="$NETWORKS" --quiet

# ---- Step 4: Run pg_dump ----
echo "=== Step 4: Running pg_dump ==="
mkdir -p "$(dirname "$OUTPUT")"

pg_dump \
  --host="$INSTANCE_IP" \
  --port=5432 \
  --username="$DB_USER" \
  --dbname="$DATABASE" \
  --no-owner \
  --no-acl \
  --format=plain \
  --connect-timeout=30 \
  --file="$OUTPUT"

FILE_SIZE=$(ls -lh "$OUTPUT" | awk '{print $5}')
echo "Export complete: ${OUTPUT} (${FILE_SIZE})"

# ---- Step 5: Cleanup is handled by trap ----
echo ""
echo "=== Done ==="
