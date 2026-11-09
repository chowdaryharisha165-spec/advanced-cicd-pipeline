#!/usr/bin/env bash
set -euo pipefail

echo "=== [SETUP] Verifying prerequisites and environment ==="
for cmd in docker git curl; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "[-] Missing required command: $cmd"
    exit 1
  fi
  echo "[+] Found: $cmd"
done

mkdir -p logs data backups
echo "[✓] Environment setup completed successfully."
