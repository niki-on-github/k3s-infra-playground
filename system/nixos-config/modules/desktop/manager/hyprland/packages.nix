{ pkgs, inputs, nixpkgs-unstable, ... }:

{
  home-manager.users.${inputs.self.user}.home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    pass-wayland
    wf-recorder
    grim
    nixpkgs-unstable.mpvpaper
    slurp
    swappy
    wlr-randr
  ];
}
