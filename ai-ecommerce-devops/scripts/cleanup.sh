#!/usr/bin/env bash
set -euo pipefail

echo "=== [CLEANUP] Removing dangling Docker assets and temporary logs ==="
docker container prune -f || true
docker network prune -f || true
rm -rf logs/* 2>/dev/null || true

echo "[✓] Cleanup completed."
