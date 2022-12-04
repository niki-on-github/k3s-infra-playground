{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware.nix
    inputs.self.nixosProfiles.desktop
  ];
}
