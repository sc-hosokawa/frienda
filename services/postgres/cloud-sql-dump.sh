#!/usr/bin/env bash
#
# Cloud SQL pg_dump スクリプト
#
# Cloud SQL インスタンスからデータベースをエクスポートする。
# 一時的にパブリックIPを割り当て、現在のIPを許可リストに追加し、
# pg_dump 実行後にセキュリティ設定を元に戻す。
#
# 注意: このスクリプトはリポジトリルートから実行してください。
# 注意: Cloud SQL authorized networks は IPv4 のみ対応のため、
#       このスクリプトも IPv4 アドレスのみをサポートします。
#
# Usage:
#   ./services/postgres/cloud-sql-dump.sh [options]
#
# Options:
#   -i, --instance   Cloud SQL instance name (default: frienda-dev-pg)
#   -d, --database   Database name (default: frienda-pg)
#   -u, --user       Database user (default: frienda-pg)
#   -o, --output     Output file path (default: services/postgres/frienda-pg-dump.sql)
#   -f, --force      Overwrite existing output file without confirmation
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
FORCE=false
RETRY_COUNT=5
RETRY_INTERVAL=5
GCLOUD_TIMEOUT=300

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
  -f, --force      Overwrite existing output file without confirmation
  -h, --help       Show this help message

Environment variables:
  PGPASSWORD       Database password (required, or will be prompted)

Note:
  Cloud SQL authorized networks は IPv4 のみ対応のため、
  このスクリプトも IPv4 アドレスのみをサポートします。
HELP
}

# ---- Parse arguments ----
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--instance) INSTANCE="$2"; shift 2 ;;
    -d|--database) DATABASE="$2"; shift 2 ;;
    -u|--user)     DB_USER="$2"; shift 2 ;;
    -o|--output)   OUTPUT="$2"; shift 2 ;;
    -f|--force)    FORCE=true; shift ;;
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

# ---- Check existing output file ----
if [[ -f "$OUTPUT" && "$FORCE" = false ]]; then
  FILE_SIZE=$(ls -lh "$OUTPUT" | awk '{print $5}')
  echo "Warning: Output file already exists: ${OUTPUT} (${FILE_SIZE})"
  echo -n "Overwrite? [y/N]: "
  read -r CONFIRM
  if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "Aborted."
    exit 0
  fi
fi

# ---- Password handling ----
# PGPASSWORD is passed inline to pg_dump to limit its scope
if [[ -z "${PGPASSWORD:-}" ]]; then
  echo -n "Enter password for ${DB_USER}@${DATABASE}: "
  read -rs PGPASSWORD
  echo
fi

# ---- Helper: extract PRIMARY IP from gcloud JSON ----
# Uses gcloud --format to filter PRIMARY type IP addresses
get_primary_ip() {
  gcloud sql instances describe "$1" \
    --format="csv[no-heading](ipAddresses.ipAddress,ipAddresses.type)" 2>/dev/null \
    | grep ',PRIMARY$' \
    | cut -d',' -f1 \
    | head -1 || echo ""
}

# ---- Helper: get authorized networks as comma-separated list ----
get_authorized_networks() {
  gcloud sql instances describe "$1" \
    --format="value(settings.ipConfiguration.authorizedNetworks.map().extract(value).flatten())" 2>/dev/null || echo ""
}

# ---- State tracking for cleanup ----
ORIGINAL_NETWORKS=""
HAD_PUBLIC_IP=false

# ---- Save existing state ----
echo "=== Saving existing Cloud SQL state ==="

# Check if public IP (PRIMARY) is already assigned
EXISTING_IP=$(get_primary_ip "$INSTANCE")
if [[ -n "$EXISTING_IP" ]]; then
  HAD_PUBLIC_IP=true
  echo "Public IP already assigned: ${EXISTING_IP}"
fi

# Save existing authorized networks
ORIGINAL_NETWORKS=$(get_authorized_networks "$INSTANCE")
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
timeout "$GCLOUD_TIMEOUT" gcloud sql instances patch "$INSTANCE" --assign-ip

# ---- Step 2: Get instance public IP (with retry) ----
echo "=== Step 2: Getting instance public IP ==="
INSTANCE_IP=""
for attempt in $(seq 1 "$RETRY_COUNT"); do
  INSTANCE_IP=$(get_primary_ip "$INSTANCE")
  if [[ -n "$INSTANCE_IP" ]]; then
    break
  fi
  echo "Waiting for public IP assignment... (attempt ${attempt}/${RETRY_COUNT})"
  sleep "$RETRY_INTERVAL"
done

if [[ -z "$INSTANCE_IP" ]]; then
  echo "Error: Could not retrieve instance public IP after ${RETRY_COUNT} attempts." >&2
  exit 1
fi
echo "Instance IP: ${INSTANCE_IP}"

# ---- Step 3: Get current public IP and authorize ----
echo "=== Step 3: Authorizing current IP ==="
# Note: Cloud SQL authorized networks only supports IPv4
MY_IP=""
MY_IP=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null || echo "")
if [[ -z "$MY_IP" ]]; then
  echo "api.ipify.org unavailable, trying ifconfig.me..."
  MY_IP=$(curl -s --max-time 5 https://ifconfig.me 2>/dev/null || echo "")
fi
if [[ -z "$MY_IP" || ! "$MY_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Could not determine public IPv4 address." >&2
  echo "Note: This script only supports IPv4 (Cloud SQL authorized networks requirement)." >&2
  exit 1
fi
echo "My IP: ${MY_IP}"

# Append current IP to existing authorized networks (preserve existing)
if [[ -n "$ORIGINAL_NETWORKS" ]]; then
  NETWORKS="${ORIGINAL_NETWORKS},${MY_IP}/32"
else
  NETWORKS="${MY_IP}/32"
fi
timeout "$GCLOUD_TIMEOUT" gcloud sql instances patch "$INSTANCE" \
  --authorized-networks="$NETWORKS" --quiet

# ---- Step 4: Run pg_dump ----
echo "=== Step 4: Running pg_dump ==="
mkdir -p "$(dirname "$OUTPUT")"

PGPASSWORD="$PGPASSWORD" pg_dump \
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
