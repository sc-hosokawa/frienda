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
# 注意: 同時実行は避けてください。複数の開発者が同時に実行すると、
#       authorized networks の設定が競合する可能性があります。
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
#   GCLOUD_TIMEOUT   Timeout in seconds for gcloud commands (default: 300)
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
GCLOUD_TIMEOUT="${GCLOUD_TIMEOUT:-300}"
MAX_BACKOFF_INTERVAL=60

# ---- Logging helper ----
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

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
  GCLOUD_TIMEOUT   Timeout in seconds for gcloud commands (default: 300)

Note:
  Cloud SQL authorized networks は IPv4 のみ対応のため、
  このスクリプトも IPv4 アドレスのみをサポートします。
  同時実行は避けてください（authorized networks の競合防止）。
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

# ---- pg_dump version check ----
LOCAL_PG_VERSION=$(pg_dump --version | grep -oE '[0-9]+' | head -1)
log "Local pg_dump major version: ${LOCAL_PG_VERSION}"
CLOUD_PG_VERSION=$(timeout "$GCLOUD_TIMEOUT" gcloud sql instances describe "$INSTANCE" \
  --format="value(databaseVersion)" 2>/dev/null | grep -oE '[0-9]+' || echo "")
if [[ -n "$CLOUD_PG_VERSION" ]]; then
  log "Cloud SQL PostgreSQL major version: ${CLOUD_PG_VERSION}"
  if [[ "$LOCAL_PG_VERSION" -lt "$CLOUD_PG_VERSION" ]]; then
    echo "Warning: Local pg_dump (v${LOCAL_PG_VERSION}) is older than Cloud SQL (v${CLOUD_PG_VERSION})." >&2
    echo "This may cause compatibility issues. Consider upgrading pg_dump." >&2
  fi
fi

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

# ---- Helper: extract PRIMARY IP from gcloud ----
get_primary_ip() {
  timeout "$GCLOUD_TIMEOUT" gcloud sql instances describe "$1" \
    --format="csv[no-heading](ipAddresses.ipAddress,ipAddresses.type)" 2>/dev/null \
    | grep ',PRIMARY$' \
    | cut -d',' -f1 \
    | head -1 || echo ""
}

# ---- Helper: get authorized networks as comma-separated list ----
# Uses gcloud --format with semicolon separator, then converts to comma-separated.
# Verified to work with gcloud CLI 400+. Falls back to empty string on parse failure.
get_authorized_networks() {
  local raw=""
  raw=$(timeout "$GCLOUD_TIMEOUT" gcloud sql instances describe "$1" \
    --format="value(settings.ipConfiguration.authorizedNetworks.map().extract(value).flatten())" 2>/dev/null) || raw=""
  # gcloud value format uses semicolons as separators; normalize to commas
  echo "$raw" | tr ';' ','
}

# ---- State tracking for cleanup ----
ORIGINAL_NETWORKS=""
HAD_PUBLIC_IP=false

# ---- Save existing state ----
log "=== Saving existing Cloud SQL state ==="

# Check if public IP (PRIMARY) is already assigned
EXISTING_IP=$(get_primary_ip "$INSTANCE")
if [[ -n "$EXISTING_IP" ]]; then
  HAD_PUBLIC_IP=true
  log "Public IP already assigned: ${EXISTING_IP}"
fi

# Save existing authorized networks
ORIGINAL_NETWORKS=$(get_authorized_networks "$INSTANCE")
if [[ -n "$ORIGINAL_NETWORKS" ]]; then
  log "Existing authorized networks: ${ORIGINAL_NETWORKS}"
else
  log "No existing authorized networks."
fi

# ---- Cleanup function (restore security settings) ----
cleanup() {
  echo ""
  log "=== Cleaning up ==="

  # Clear password from shell variable
  unset PGPASSWORD 2>/dev/null || true

  # Remove temp file if it exists
  if [[ -n "${TMPFILE:-}" && -f "$TMPFILE" ]]; then
    rm -f "$TMPFILE"
  fi

  # Restore authorized networks to original state
  if [[ -n "$ORIGINAL_NETWORKS" ]]; then
    log "Restoring original authorized networks: ${ORIGINAL_NETWORKS}"
    gcloud sql instances patch "$INSTANCE" \
      --authorized-networks="$ORIGINAL_NETWORKS" --quiet 2>/dev/null || true
  else
    log "Clearing authorized networks (none existed before)..."
    gcloud sql instances patch "$INSTANCE" \
      --clear-authorized-networks --quiet 2>/dev/null || true
  fi

  # Only disable public IP if it wasn't assigned before
  if [[ "$HAD_PUBLIC_IP" = false ]]; then
    log "Disabling public IP (was not assigned before)..."
    gcloud sql instances patch "$INSTANCE" --no-assign-ip --quiet 2>/dev/null || true
  else
    log "Keeping public IP (was already assigned before script execution)."
  fi

  log "Cleanup complete."
}
trap cleanup EXIT

# ---- Step 1: Assign public IP ----
log "=== Step 1: Assigning public IP to ${INSTANCE} ==="
timeout "$GCLOUD_TIMEOUT" gcloud sql instances patch "$INSTANCE" --assign-ip

# ---- Step 2: Get instance public IP (with retry + exponential backoff) ----
log "=== Step 2: Getting instance public IP ==="
INSTANCE_IP=""
BACKOFF_INTERVAL="$RETRY_INTERVAL"
for attempt in $(seq 1 "$RETRY_COUNT"); do
  INSTANCE_IP=$(get_primary_ip "$INSTANCE")
  if [[ -n "$INSTANCE_IP" ]]; then
    break
  fi
  log "Waiting for public IP assignment... (attempt ${attempt}/${RETRY_COUNT}, next retry in ${BACKOFF_INTERVAL}s)"
  sleep "$BACKOFF_INTERVAL"
  BACKOFF_INTERVAL=$(( BACKOFF_INTERVAL * 2 > MAX_BACKOFF_INTERVAL ? MAX_BACKOFF_INTERVAL : BACKOFF_INTERVAL * 2 ))
done

if [[ -z "$INSTANCE_IP" ]]; then
  echo "Error: Could not retrieve instance public IP after ${RETRY_COUNT} attempts." >&2
  exit 1
fi
log "Instance IP: ${INSTANCE_IP}"

# ---- Step 3: Get current public IP and authorize ----
log "=== Step 3: Authorizing current IP ==="
# Note: Cloud SQL authorized networks only supports IPv4.
# api4.ipify.org guarantees IPv4 response (unlike api.ipify.org which may return IPv6 on dual-stack).
MY_IP=""
MY_IP=$(curl -s --max-time 5 https://api4.ipify.org 2>/dev/null || echo "")
if [[ -z "$MY_IP" ]]; then
  log "api4.ipify.org unavailable, trying ifconfig.me..."
  MY_IP=$(curl -4 -s --max-time 5 https://ifconfig.me 2>/dev/null || echo "")
fi
# Validate IPv4 format (each octet 0-255)
validate_ipv4() {
  local ip="$1"
  local IFS='.'
  read -ra octets <<< "$ip"
  [[ ${#octets[@]} -eq 4 ]] || return 1
  for octet in "${octets[@]}"; do
    [[ "$octet" =~ ^[0-9]+$ ]] || return 1
    (( octet >= 0 && octet <= 255 )) || return 1
  done
  return 0
}
if [[ -z "$MY_IP" ]] || ! validate_ipv4 "$MY_IP"; then
  echo "Error: Could not determine public IPv4 address." >&2
  echo "Note: This script only supports IPv4 (Cloud SQL authorized networks requirement)." >&2
  exit 1
fi
log "My IP: ${MY_IP}"

# Append current IP to existing authorized networks (preserve existing)
if [[ -n "$ORIGINAL_NETWORKS" ]]; then
  NETWORKS="${ORIGINAL_NETWORKS},${MY_IP}/32"
else
  NETWORKS="${MY_IP}/32"
fi
timeout "$GCLOUD_TIMEOUT" gcloud sql instances patch "$INSTANCE" \
  --authorized-networks="$NETWORKS" --quiet

# ---- Step 4: Run pg_dump (via temp file for atomicity) ----
log "=== Step 4: Running pg_dump ==="
mkdir -p "$(dirname "$OUTPUT")"

TMPFILE=$(mktemp "${OUTPUT}.XXXXXX")
chmod 600 "$TMPFILE"

PGPASSWORD="$PGPASSWORD" pg_dump \
  --host="$INSTANCE_IP" \
  --port=5432 \
  --username="$DB_USER" \
  --dbname="$DATABASE" \
  --no-owner \
  --no-acl \
  --format=plain \
  --connect-timeout=30 \
  --file="$TMPFILE"

mv "$TMPFILE" "$OUTPUT"

FILE_SIZE=$(ls -lh "$OUTPUT" | awk '{print $5}')
log "Export complete: ${OUTPUT} (${FILE_SIZE})"

# ---- Step 5: Cleanup is handled by trap ----
echo ""
log "=== Done ==="
