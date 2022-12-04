{ config, lib, pkgs, ... }:

{
  hardware.opengl.enable = true;

  environment = {
    # VMS settings
    variables = {
      LIBCL_ALWAYS_SOFTWARE = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling
        wev
        waybar
        wl-clipboard
        xwayland
        wayvnc
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 5900 ]; # Used for vnc

  xdg.portal = { # Required for flatpak with windowmanagers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
