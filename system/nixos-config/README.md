# NixOS config

## Installation

```bash
nix-channel update
nix flake update
sudo nixos-rebuild switch  --flake '.#server' --upgrade
```
