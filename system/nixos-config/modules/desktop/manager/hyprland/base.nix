{ pkgs, lib, config, nixpkgs-unstable, inputs, ... }:

{
  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS="1";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  programs.xwayland.enable = true;

  services.dbus.enable = true;

  # does only work with QXL video not virtio!
  environment = {
    # loginShellInit = ''
    #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    #     exec WLR_NO_HARDWARE_CURSORS=1 WLR_RENDERER_ALLOW_SOFTWARE=1 HYPRLAND_LOG_WLR=1 Hyprland
    #   fi
    # '';                                   # TODO WLR_RENDERER_ALLOW_SOFTWARE=1 required in VMs remove this on hw install!!!
    variables = {
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    systemPackages = with pkgs; [
      grim
      nixpkgs-unstable.mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
    ];
  };

  programs = {
    hyprland.enable = true;
  };
}
