#!/bin/bash
set -euo pipefail

echo "Checking if required tools are installed..."

MISSING_TOOLS=0
REPORT="Toolbox validation result:\n"

check_tool() {
  if command -v "$1" &>/dev/null; then
    echo "[OK] $1 is installed"
    REPORT+="[OK] $1 is installed\n"
  else
    echo "[MISSING] $1 is NOT installed"
    REPORT+="[MISSING] $1 is NOT installed\n"
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

SUMMARY_MSG=""

if [[ $MISSING_TOOLS -gt 0 ]]; then
  SUMMARY_MSG="❌ $MISSING_TOOLS tool(s) missing."
else
  SUMMARY_MSG="✅ All tools installed."
fi

curl -s \
  -F "token=${PUSHOVER_API_TOKEN}" \
  -F "user=${PUSHOVER_USER_KEY}" \
  -F "message=${SUMMARY_MSG}" \
  https://api.pushover.net/1/messages.json

exit 0