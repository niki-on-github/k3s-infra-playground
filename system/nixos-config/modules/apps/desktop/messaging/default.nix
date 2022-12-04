{ pkgs, inputs, ... }:

{
  home-manager.users.${inputs.self.user} = {
    home.packages = with pkgs; [
      discord
      element-desktop
      signal-desktop
    ];
  };
}
