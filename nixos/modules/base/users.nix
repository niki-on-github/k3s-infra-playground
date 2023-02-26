{ pkgs, inputs, ... }:

{
  users = {
    mutableUsers = true;
    users = {
      ${inputs.self.user} = {
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
          "libvirtd"
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

  programs.zsh = {
    enable = true;
  };

  environment.shells = with pkgs; [ zsh ];
  nix.settings.trusted-users = [ "root" "${inputs.self.user}" ];
}
