{ pkgs, inputs, ... }:

{
  home-manager.users.${inputs.self.user} = {
    home.packages = with pkgs; [
      mpv
      spotify
      gimp
      sxiv
      swayimg
    ];
  };
}
