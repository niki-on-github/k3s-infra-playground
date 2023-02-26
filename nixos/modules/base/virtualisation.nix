{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    replicate-cog
    libvirt
    virtmanager
    (my-python.withPackages (p: with p; [
      cryptography
      docker
      libvirt
      python3-docker-compose
      requests
    ]))
  ];

  # required for virtualisation.docker.enableNvidia
  hardware.opengl.driSupport32Bit = true;

  networking.firewall.allowedTCPPorts = [ 5900 ];

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize =  8192;
      cores = 8;
    };
  };

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
