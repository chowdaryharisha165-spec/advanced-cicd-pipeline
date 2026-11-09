#!/usr/bin/env bash
set -euo pipefail

ENV="${1:-local}"
echo "=== [DEPLOY] Triggering deployment for environment: ${ENV} ==="

if [ "$ENV" = "local" ]; then
  echo "[+] Deploying with Docker Compose..."
  docker compose -f docker/docker-compose.yml up -d --build
elif [ "$ENV" = "k8s" ]; then
  echo "[+] Deploying with Kubernetes..."
  kubectl apply -f kubernetes/
else
  echo "[-] Unknown deployment environment: ${ENV}"
  exit 1
fi

echo "[✓] Deployment initiated."
