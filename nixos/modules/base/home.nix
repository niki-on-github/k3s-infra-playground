{ config, inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${inputs.self.user} = {
      news.display = "silent";
      systemd.user.startServices = true;
      home.stateVersion = "21.11";
    };
  };
}
