
{
  description = "My Personal NixOS System Flake Configuration";

  inputs =
    {
      nixpkgs = {
        url = "github:NixOS/nixpkgs/nixos-22.05";
      };

      nixpkgs-unstable = {
        url = "github:nixos/nixpkgs/nixos-unstable";
      };

      k3s-pinned = {
        url = "github:nixos/nixpkgs/73994921df2b89021c1cbded66e8f057a41568c1";
      };

      sops-nix = {
        url = "github:Mic92/sops-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      deploy-rs = {
        url = "github:serokell/deploy-rs";
      };

      home-manager = {
        url = "github:nix-community/home-manager/release-22.05";
      };

      nur = {
        url = "github:nix-community/NUR";
      };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, deploy-rs, home-manager, nur, sops-nix, k3s-pinned, ... } @ inputs :
    let
      inherit (nixpkgs) lib;
      util = import ./util { inherit lib; };
      overlays = [
        nur.overlay
        (final: prev: { k3s = (import k3s-pinned { system = "${prev.system}"; config = { allowUnfree = true; }; }).k3s;})
      ];
      nixosDeployments = util.genNixosConfigs {
        inherit inputs;
        inherit deploy-rs;
        path = ./hosts;
        sharedModules = [
          { nixpkgs.overlays = overlays; }
          sops-nix.nixosModules.sops
        ];
      };
    in {
      inherit (nixosDeployments) nixosConfigurations deploy;

      nixosModules = import ./modules;
      nixosProfiles = import ./profiles;

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    };
}
