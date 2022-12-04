{ inputs, pkgs, ... }:

{
  home-manager.users.${inputs.self.user} = {
    programs.git = {
      enable = true;
      userName = "${inputs.self.user}";
      userEmail = "${inputs.self.user}@local";
      delta.enable = true;
      lfs.enable = true;
    };

    home.packages = with pkgs; [ delta ];
  };
}
