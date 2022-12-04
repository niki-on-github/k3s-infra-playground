{ config, lib, pkgs, modulesPath, ... }:

let
  lone_plymouth_theme = pkgs.callPackage ./plymouth/lone.nix { };
in
{
  boot = {
    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = [ lone_plymouth_theme ];
    };

    # Delete all files in /tmp during boot
    cleanTmpDir = true;

    # quite - Don't show terminal output unless an error occurs
    # splash - Show splash screen theme (if available)
    kernelParams = [ "quiet" "splash" ];

    # All Kernel Messages with a log level smaller
    # than this setting will be printed to the console
    consoleLogLevel = 3;
  };
}
