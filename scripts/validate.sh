#!/usr/bin/env bash
set -euo pipefail

if command -v kubectl >/dev/null 2>&1; then
  kubectl kustomize clusters/k3s-master >/tmp/homelab-gitops-rendered.yaml
  echo "Rendered clusters/k3s-master successfully"
else
  echo "kubectl not found; skipping kustomize render"
fi

find . -name '*.sh' -print0 | xargs -0 -n1 bash -n
