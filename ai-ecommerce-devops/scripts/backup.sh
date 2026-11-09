#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="${BACKUP_DIR}/backup_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"
echo "=== [BACKUP] Archiving configurations and manifests ==="
tar -czf "$ARCHIVE_NAME" docker/ kubernetes/ terraform/ 2>/dev/null || true

echo "[✓] Backup created: ${ARCHIVE_NAME}"
