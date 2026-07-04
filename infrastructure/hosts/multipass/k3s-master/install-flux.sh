#!/usr/bin/env bash
set -euo pipefail

VM_NAME="${VM_NAME:-k3s-master}"

multipass exec "$VM_NAME" -- bash -lc '
  set -euo pipefail
  if ! command -v flux >/dev/null 2>&1; then
    curl -s https://fluxcd.io/install.sh | sudo bash
  fi
  mkdir -p ~/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
  sudo chown $(id -u):$(id -g) ~/.kube/config
  flux install
  flux check
  sudo k3s kubectl get pods -n flux-system
'
