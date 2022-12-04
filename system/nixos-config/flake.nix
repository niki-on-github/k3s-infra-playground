
{
  description = "My Personal NixOS System Flake Configuration";

  inputs =
    {
      nixpkgs = {
        # url = "github:NixOS/nixpkgs/nixos-22.11";
        url = "github:nixos/nixpkgs/nixos-unstable";
      };

      nixpkgs-unstable = {
        url = "github:nixos/nixpkgs/nixos-unstable";
      };

      sops-nix = {
        url = "github:Mic92/sops-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      deploy-rs = {
        url = "github:serokell/deploy-rs";
      };

      home-manager = {
        url = "github:nix-community/home-manager/release-22.11";
      };

      nur = {
        url = "github:nix-community/NUR";
      };

      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, deploy-rs, home-manager, nur, sops-nix, hyprland, ... } @ inputs :
    let
      inherit (nixpkgs) lib;
      util = import ./util { inherit lib; };
      overlays = lib.flatten [
        nur.overlay
        (import ./overlays { inherit lib; }).overlays
      ];
      nixosDeployments = util.generateNixosDeployments {
        inherit inputs;
        inherit deploy-rs;
        path = ./hosts;
        sharedModules = [
          { nixpkgs.overlays = overlays; }
          hyprland.nixosModules.default
          sops-nix.nixosModules.sops
        ];
      };
    in {
      inherit (nixosDeployments) nixosConfigurations deploy;

      nixosModules = import ./modules;
      nixosProfiles = import ./profiles;

      user = "nix";

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    };
}
