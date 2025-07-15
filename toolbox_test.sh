#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "Checking if required tools are installed..."

TOOLS=(
  kubectl
  helm
  terraform
  az
  ssh
  crictl
  velero
  sentinel
  stern
  kubelogin
  oc
  aws
  gcloud
  ansible
  vault
  pip
)

FAILED=0

for tool in "${TOOLS[@]}"; do
  if command -v "$tool" &>/dev/null; then
    echo "[OK] $tool is installed"
  else
    echo "[MISSING] $tool is NOT installed"
    FAILED=1
  fi
done

if [[ "$FAILED" -eq 0 ]]; then
  echo "[SUCCESS] All tools are installed."
else
  echo "[FAILURE] Some tools are missing."
  exit 1
fi