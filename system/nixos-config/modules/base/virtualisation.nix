{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    replicate-cog
    (my-python.withPackages (p: with p; [
      python3-docker-compose
      cryptography
      requests
      docker
      docker-compose
    ]))
  ];

  # required for virtualisation.docker.enableNvidia
  hardware.opengl.driSupport32Bit = true;

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;

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
