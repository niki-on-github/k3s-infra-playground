
{
  description = "My Personal NixOS System Flake Configuration";

  inputs =
    {
      nixos-hardware = {
        type = "github";
        owner = "NixOS";
        repo = "nixos-hardware";
        flake = false;
      };

      nixpkgs = {
        url = "github:NixOS/nixpkgs/nixos-22.05";
      };

      nixpkgs-unstable = {
        url = "github:nixos/nixpkgs/nixos-unstable";
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

      nixpkgs-fmt = {
        url = "github:nix-community/nixpkgs-fmt";
        flake = false;
      };

      hyprland = {
        url = "github:vaxerski/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = { self, nixpkgs, nixpkgs-unstable, deploy-rs, home-manager, nur, nixpkgs-fmt, hyprland, ... } @ inputs : {

    nixosModules = import ./modules;
    nixosProfiles = import ./profiles;

    nixosConfigurations = with nixpkgs.lib;
      let
        hosts = builtins.attrNames (builtins.readDir ./hosts);
        mkHost = name:
          nixosSystem {
            system = "x86_64-linux";
            modules =
              let
                defaults = { pkgs, ... }: {
                  _module.args.nixpkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
                };
              in
              [
                defaults
                (import (./hosts + "/${name}"))
                { nixpkgs.overlays = [ nur.overlay ]; }
              ];
            specialArgs = { inherit inputs; };
          };
      in
      genAttrs hosts mkHost;

    legacyPackages.x86_64-linux =
      (builtins.head (builtins.attrValues self.nixosConfigurations)).pkgs;

    defaultApp = deploy-rs.defaultApp;

    deploy = {
      user = "root";
      nodes.server = {
        hostname = self.nixosConfigurations.server.config.networking.hostName;
        profiles.system.path = deploy-rs.x86_64-linux.activate.nixos self.nixosConfigurations.server;
      };
    };
  };
}
