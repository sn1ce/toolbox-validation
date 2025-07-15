#!/bin/bash
set -euo pipefail

echo "Checking if required tools are installed..."

MISSING_TOOLS=0

check_tool() {
  if command -v "$1" &>/dev/null; then
    echo "[OK] $1 is installed"
  else
    echo "[MISSING] $1 is NOT installed"
    MISSING_TOOLS=$((MISSING_TOOLS + 1))
  fi
}

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

for tool in "${TOOLS[@]}"; do
  check_tool "$tool"
done

if [[ $MISSING_TOOLS -gt 0 ]]; then
  echo "[FAILURE] Some tools are missing ($MISSING_TOOLS total)."
else
  echo "[SUCCESS] All tools are installed."
fi

# Always exit 0, regardless of result
exit 0