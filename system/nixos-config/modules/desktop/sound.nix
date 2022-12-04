{ pkgs, inputs, ... }:

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

    # For compatibility with 32-bit applications
    support32Bit = true;
  };

  home-manager.users.${inputs.self.user}.home.packages = with pkgs; [
    pamixer
  ];
}
