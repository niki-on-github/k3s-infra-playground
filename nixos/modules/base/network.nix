{
  services.resolved.enable = true;
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    useDHCP = false;
  };
}
