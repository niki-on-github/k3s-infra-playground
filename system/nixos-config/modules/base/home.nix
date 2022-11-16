{ config, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.nix = {
      news.display = "silent";
      systemd.user.startServices = true;
      home.stateVersion = "21.11";
    };
  };
}
