# Homelab GitOps

GitOps/IaC baseline for the local homelab k3s cluster running on Multipass.

## Current topology

```text
Physical host: 192.168.1.17
  └─ Multipass VM: k3s-master
       ├─ Ubuntu 24.04 LTS
       ├─ CPU: 2
       ├─ RAM: 4GB
       ├─ Disk: 10GB
       └─ k3s single-node cluster
            └─ Flux CD controllers
```

## Layers

- `infrastructure/hosts/multipass/k3s-master`: host/VM provisioning and k3s bootstrap scripts.
- `clusters/k3s-master`: cluster desired state reconciled by Flux.
- `platform`: reusable platform components such as ingress, storage, monitoring, secrets.
- `apps`: application manifests and overlays.

## Quick start

From the physical host with Multipass installed:

```bash
cd infrastructure/hosts/multipass/k3s-master
./create-vm.sh
./install-k3s.sh
./install-flux.sh
```

Export kubeconfig to your workstation if needed:

```bash
multipass exec k3s-master -- sudo cat /etc/rancher/k3s/k3s.yaml > kubeconfig
# replace 127.0.0.1 with the VM IP from `multipass info k3s-master`
```

## Bootstrap Flux to GitHub

After pushing this repo to GitHub, run inside `k3s-master` or any machine with kubeconfig:

```bash
export GITHUB_TOKEN=<token>
flux bootstrap github \
  --owner=<github-user-or-org> \
  --repository=homelab-gitops \
  --branch=main \
  --path=clusters/k3s-master \
  --personal
```

## Recommended GitOps flow

1. Change manifests/scripts in Git.
2. Open PR and run validation.
3. Merge to `main`.
4. Flux reconciles `clusters/k3s-master`.

## Notes

- Flux is installed in-cluster, but this repo is the source of truth after bootstrap.
- Multipass provisioning is represented as scripts because Multipass does not have a mature official Terraform/OpenTofu provider.
- If moving to Proxmox/cloud later, keep `clusters/`, `platform/`, and `apps/`; replace only `infrastructure/hosts/`.
