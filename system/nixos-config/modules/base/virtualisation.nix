{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    (my-python.withPackages (p: with p; [
      python3-docker-compose
      cryptography
      requests
      docker
      docker-compose
    ]))
  ];
  virtualisation = {
    docker = {
      enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    libvirtd.enable = true;

    # Allow unprivileged user to pass USB devices connected to
    # this machine to libvirt VMs, both local and remote
    spiceUSBRedirection.enable = true;
  };
}
