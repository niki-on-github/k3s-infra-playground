{ config, pkgs, lib, inputs, ... }:

let
  fonts = config.themes.fonts;
in
{
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_DBUS_REMOTE = "1";
    MOZ_ENABLE_WAYLAND= "1";
  };

  home-manager.users.${inputs.self.user} = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ublock-origin
      ];
      profiles.default = {
        id = 0;
        settings = {
          "extensions.autoDisableScopes" = 0;

          "browser.search.defaultenginename" = "Startpage.com - English";
          "browser.search.selectedEngine" = "Startpage.com - English";
          "browser.urlbar.placeholderName" = "Startpage.com - English";
          "browser.search.region" = "US";
          "browser.startup.homepage" = "about:blank";
          "browser.newtabpage.enabled" = true;

          "font.name.monospace.x-western" = "${fonts.mono.family}";
          "font.name.sans-serif.x-western" = "${fonts.main.family}";
          "font.name.serif.x-western" = "${fonts.serif.family}";

          "browser.toolbars.bookmarks.visibility" = "always";

          "browser.uidensity" = 1;
          "browser.search.openintab" = true;

          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.theme.toolbar-theme" = 0;
          "browser.theme.content-theme" = 0;

          "signon.rememberSignons" = true;

          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "network.allow-experiments" = false;
        };
      };
    };
  };
}
