{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
  ];
  home-manager.users.${inputs.self.user} = {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
    };

    home.packages = with pkgs; [
      my-python.withPackages (p: with p; [
          pynvim
      ]))
    ];
  };
}
