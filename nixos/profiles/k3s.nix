{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./base.nix

    modules-apps-server-k3s
  ];
}
