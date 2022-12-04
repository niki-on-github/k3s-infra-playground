{ pkgs, lib, inputs, ... }:
{

  environment.sessionVariables = {
    XCURSOR_PATH = lib.mkForce "/home/nix/.icons";
  };

  home-manager.users.${inputs.self.user} = {
    home.pointerCursor = {
      package = pkgs.breeze-qt5;
      name = "Breeze";
    };
  };
}
