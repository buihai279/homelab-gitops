#!/usr/bin/env bash
set -euo pipefail

VM_NAME="${VM_NAME:-k3s-master}"
IMAGE="${IMAGE:-24.04}"
CPUS="${CPUS:-2}"
MEMORY="${MEMORY:-4G}"
DISK="${DISK:-10G}"

if multipass info "$VM_NAME" >/dev/null 2>&1; then
  echo "VM $VM_NAME already exists"
  multipass info "$VM_NAME"
  exit 0
fi

multipass launch "$IMAGE" \
  --name "$VM_NAME" \
  --cpus "$CPUS" \
  --memory "$MEMORY" \
  --disk "$DISK"

multipass info "$VM_NAME"
