{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./base.nix

    modules-vm-qemu
    modules-desktop
    modules-desktop-manager-sway
    modules-apps-desktop
  ];
}
