{ pkgs, ... }:

{
  imports = [
    ./base.nix
    ./compression.nix
    ./http.nix
    ./disk.nix
    ./network.nix
  ];
}
