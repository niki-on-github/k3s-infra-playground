{ pkgs, ... }:

{
  hardware.video.hidpi.enable = true;

  environment.systemPackages = with pkgs; [
    cachix
    xclip
    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS="1";
  };

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "no";

  networking.firewall.enable = false;
  virtualisation.vmware.guest.enable = true;
}
