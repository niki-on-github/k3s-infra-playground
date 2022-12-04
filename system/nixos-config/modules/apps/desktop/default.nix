{ pkgs, config, lib, inputs, ... }: {

    imports = [
      ./dev
      ./editor
      ./media
      ./filemanager
      ./messaging
      ./monitoring
      ./pentest
      ./reading
      ./shell
      ./terminal
      ./utils
      ./web
  ];

  options.defaultApps = lib.mkOption {
    type = lib.types.attrs;
    description = "Preferred applications";
  };

  config = rec {
    defaultApps = {
      term = {
        cmd = "${pkgs.alacritty}/bin/alacritty";
        desktop = "alacritty";
      };
      editor = {
        cmd = "${pkgs.vscodium}/bin/vscodium $@";
        desktop = "vscodium";
      };
      browser = {
        cmd = "${pkgs.firefox}/bin/firefox";
        desktop = "firefox";
      };
      fm = {
        cmd = "${pkgs.lf}/bin/lf";
        desktop = "lf";
      };
      reader = {
        cmd = "${pkgs.zathura}/bin/zathura";
        desktop = "zathura";
      };
      messenger = {
        cmd = "${pkgs.signal}/bin/signal";
        desktop = "signal";
      };
    };

    environment.sessionVariables = {
      EDITOR = config.defaultApps.editor.cmd;
      VISUAL = config.defaultApps.editor.cmd;
    };

    home-manager.users.${inputs.self.user}.xdg.mimeApps = {
      enable = true;
      defaultApplications = with config.defaultApps;
        builtins.mapAttrs
          (name: value:
            if value ? desktop then [ "${value.desktop}.desktop" ] else value)
          {
            "text/html" = browser;
            "application/pdf" = reader;

            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/unknown" = browser;

            "text/plain" = editor;
          };
    };
  };
}
