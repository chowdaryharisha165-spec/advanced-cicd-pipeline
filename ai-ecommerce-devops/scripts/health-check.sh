#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="${1:-http://localhost:8080/health}"
EXPECTED_STATUS="${2:-200}"

echo "=== [HEALTH CHECK] Querying ${TARGET_URL} ==="
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL" || echo "000")

if [ "$HTTP_STATUS" -eq "$EXPECTED_STATUS" ]; then
  echo "[✓] Health Check PASSED: Received HTTP ${HTTP_STATUS}"
  exit 0
else
  echo "[✗] Health Check FAILED: Expected ${EXPECTED_STATUS}, got ${HTTP_STATUS}"
  exit 1
fi
