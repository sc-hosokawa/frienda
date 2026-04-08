#!/usr/bin/env bash
#
# Cloud SQL pg_dump スクリプト
#
# Cloud SQL インスタンスからデータベースをエクスポートする。
# 一時的にパブリックIPを割り当て、現在のIPを許可リストに追加し、
# pg_dump 実行後にセキュリティ設定を元に戻す。
#
# Usage:
#   ./cloud-sql-dump.sh [options]
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

# ---- Defaults ----
INSTANCE="frienda-dev-pg"
DATABASE="frienda-pg"
DB_USER="frienda-pg"
OUTPUT="services/postgres/frienda-pg-dump.sql"

# ---- Parse arguments ----
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--instance) INSTANCE="$2"; shift 2 ;;
    -d|--database) DATABASE="$2"; shift 2 ;;
    -u|--user)     DB_USER="$2"; shift 2 ;;
    -o|--output)   OUTPUT="$2"; shift 2 ;;
    -h|--help)
      sed -n '2,/^$/{ s/^# //; s/^#$//; p }' "$0"
      exit 0
      ;;
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

# ---- Cleanup function (always restore security settings) ----
cleanup() {
  echo ""
  echo "=== Cleaning up ==="

  echo "Removing authorized networks..."
  gcloud sql instances patch "$INSTANCE" --clear-authorized-networks --quiet 2>/dev/null || true

  echo "Disabling public IP..."
  gcloud sql instances patch "$INSTANCE" --no-assign-ip --quiet 2>/dev/null || true

  echo "Cleanup complete."
}
trap cleanup EXIT

# ---- Step 1: Assign public IP ----
echo "=== Step 1: Assigning public IP to ${INSTANCE} ==="
gcloud sql instances patch "$INSTANCE" --assign-ip

# ---- Step 2: Get instance public IP ----
echo "=== Step 2: Getting instance public IP ==="
INSTANCE_IP=$(gcloud sql instances describe "$INSTANCE" \
  --format="value(ipAddresses[0].ipAddress)")
echo "Instance IP: ${INSTANCE_IP}"

# ---- Step 3: Get current public IP and authorize ----
echo "=== Step 3: Authorizing current IP ==="
MY_IP=$(curl -s https://api.ipify.org)
echo "My IP: ${MY_IP}"

gcloud sql instances patch "$INSTANCE" \
  --authorized-networks="${MY_IP}/32" --quiet

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
  --file="$OUTPUT"

FILE_SIZE=$(ls -lh "$OUTPUT" | awk '{print $5}')
echo "Export complete: ${OUTPUT} (${FILE_SIZE})"

# ---- Step 5: Cleanup is handled by trap ----
echo ""
echo "=== Done ==="
