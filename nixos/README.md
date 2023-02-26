# NixOS config

## Setup

```bash
sudo nixos-rebuild switch  --flake '.#server1' --upgrade
```

## Test inside VM

first set the port forwarding with `QEMU_NET_OPTS` env var:

```bash
export QEMU_NET_OPTS="hostfwd=tcp::2222-:22,hostfwd=tcp::6443-:6443,hostfwd=tcp::10250-:10250"
```

then start the vm with:

```bash
nix run '.#nixosConfigurations.HOSTNAME.config.system.build.vm'
```

e.g.:

```bash
nix run '.#nixosConfigurations.server1.config.system.build.vm'
```
