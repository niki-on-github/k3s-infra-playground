{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware.nix
    ./network.nix
    inputs.self.nixosProfiles.k3s
  ];
}
