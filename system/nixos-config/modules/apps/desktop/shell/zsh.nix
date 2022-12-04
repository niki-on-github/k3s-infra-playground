{ pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    killall
    zplug
    zoxide
  ];

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ bashInteractive zsh ];

  home-manager.users.${inputs.self.user} = {

    home.packages = with pkgs; [ git ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;

      zplug = {
        enable = true;
        plugins = [
          { name = "spwhitt/nix-zsh-completions"; }
          { name = "z-shell/zsh-zoxide"; }
          { name = "seletskiy/zsh-fuzzy-search-and-edit"; }
          { name = "wfxr/forgit"; }
          { name = "zsh-users/zsh-history-substring-search"; }
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-completions"; }
          { name = "zdharma-continuum/fast-syntax-highlighting"; }
          { name = "kutsan/zsh-system-clipboard"; }
          { name = "Aloxaf/fzf-tab"; }
          { name = "spaceship-prompt/spaceship-prompt"; }
        ];
      };
      history = rec {
        expireDuplicatesFirst = true;
        size = 1000000;
        save = size;
      };
      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
        update = "sudo nixos-rebuild switch";
      };

    };
  };
}
