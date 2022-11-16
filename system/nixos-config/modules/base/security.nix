{ pkgs, ... }:

{
  security = {
    sudo = {
      wheelNeedsPassword = true;
    };

    apparmor.enable = true;
  };

  programs = {
    firejail.enable = true;
  };
}
