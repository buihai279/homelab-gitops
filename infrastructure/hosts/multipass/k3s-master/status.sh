#!/usr/bin/env bash
set -euo pipefail

VM_NAME="${VM_NAME:-k3s-master}"

multipass info "$VM_NAME"
multipass exec "$VM_NAME" -- bash -lc '
  sudo k3s kubectl get nodes -o wide
  sudo k3s kubectl get pods -A
'
