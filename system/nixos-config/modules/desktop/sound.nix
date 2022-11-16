{ pkgs, ... }:

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.pulseaudio = {
    enable = false;

    # 1. Only the full build has Bluetooth support
    # 2. Enable JACK support
    package = pkgs.pulseaudioFull; # .override { jackaudioSupport = true; };

    # While pulseaudio itself only has support for the
    # SBC bluetooth codec there is out-of-tree support for AAC, APTX, APTX-HD and LDAC.
    # NixOS 21.11, in 22.05 the bt functionality is included
    # extraModules = [pkgs.pulseaudio-modules-bt];
    # For compatibility with 32-bit applications
    support32Bit = true;
  };

  home-manager.users.nix.home.packages = with pkgs; [
    pamixer
  ];
}
