#!/usr/bin/env bash
set -euo pipefail

VM_NAME="${VM_NAME:-k3s-master}"
K3S_EXEC="${K3S_EXEC:-server --write-kubeconfig-mode=644}"

multipass exec "$VM_NAME" -- bash -lc "
  set -euo pipefail
  if command -v k3s >/dev/null 2>&1; then
    echo 'k3s already installed'
  else
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='$K3S_EXEC' sh -
  fi
  sudo systemctl is-active k3s
  sudo k3s kubectl get nodes -o wide
"
