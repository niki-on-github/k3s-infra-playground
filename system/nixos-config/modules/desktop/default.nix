{ pkgs, ... }:

{
  imports = [
    ./themes.nix
    ./sound.nix
    ./opengl.nix
    ./cursor.nix
    ./base.nix
    ./fonts.nix
  ];
}
