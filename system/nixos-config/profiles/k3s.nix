{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./base.nix

    k3s
  ];
}
