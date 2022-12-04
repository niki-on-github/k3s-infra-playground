{inputs, ...}:
{
  home-manager.users.${inputs.self.user} = {
    programs.htop = {
      enable = true;
      settings = {
        vimMode = true;
        delay = 5;
        showCpuFrequency = true;
        showCpuUsage = true;
        treeView = true;
        hideUserlandThreads = true;
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };
  };
}
