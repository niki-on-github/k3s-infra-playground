# GitOps Homelab Playground

> [!WARNING]  
> This repository is no longer used by me and has been replaced by my [nixos-k3s](https://github.com/niki-on-github/nixos-k3s) repository.

This repository was used to learn the necessary basics for my homelab which later resulted in my [nixos-k3s](https://github.com/niki-on-github/nixos-k3s) repository. Feel free to look around. Be aware that not all configuration files are available in my public repository.

## Overview

This repository provides the **Infrastructure as Code**[^1] (IaC) and **GitOps**[^2] State for the following tools:

- [**NixOS**](https://nixos.org/): Linux distribution based on Nix to provide a declarative and reproducible system.
- [**Ansible**](https://www.ansible.com/): Reproducible System Configuration.
- [**Terraform**](https://www.terraform.io/): Build and Deploy VMs.
- [**Packer**](https://github.com/hashicorp/packer): Generate virtual machine images from source template.
- [**K3S**](https://k3s.io/): Lightweight certified Kubernetes distribution.
- [**Flux**](https://github.com/fluxcd/flux2): GitOps Kubernetes Operator that ensures that my cluster state matches the desired state described in this repository.
- [**Renovate**](https://github.com/renovatebot/renovate): Automatically updates third-party dependencies declared in my Git repository via pull requests.
- [**Task**](https://github.com/go-task/task): A task runner and build tool as an alternative to `Make` with simple `yaml` command declaration files.
- [**SOPS**](https://github.com/mozilla/sops): Tool for managing secrets.

For more detail information take a look into the `./docs` directory.

[^1]: Infrastructure as Code (IaC) is the process of managing and provisioning computer infrastructure through configuration files.
[^2]: GitOps is an operational framework that takes best practices from application development such as version control, collaboration, compliance, and CI/CD, and applies them to infrastructure automation.

## Deployment

From Repository run the following steps to deploy the GitOps managed Kubernetes Cluster:

1. **Install System**: Use `./nixos` flake for system installation.
2. **Setup Kubernetes Cluster**: Use `ansible` playbooks from `./ansible` for cluster setup.
3. **Deploy GitOps Kubernetes Operator**: Use runner tool `Task` to deploy `Flux` Operator to the Kubernetes Cluster.

<br>
