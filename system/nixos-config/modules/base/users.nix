{ pkgs, ... }:

{
  users = {
    mutableUsers = true;
    users = {
      nix = {
        isNormalUser = true;
        description = "nix user";
        createHome = true;
        initialPassword = "nixos";
        shell = pkgs.zsh;
        home = "/home/nix";
        extraGroups = [
          "adbusers"
          "audio"
          "audit"
          "dialout"
          "docker"
          "input"
          "jackaudio"
          "kvm"
          "lp"
          "networkmanager"
          "scanner"
          "sshusers"
          "users"
          "uucp"
          "vboxusers"
          "video"
          "wheel"
          "wireshark"
        ];
      };
    };
  };

  nix.settings.trusted-users = [ "root" "nix" ];
}
