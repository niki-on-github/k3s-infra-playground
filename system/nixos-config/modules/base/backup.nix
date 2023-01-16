{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    borgbackup
    rsync
    par2cmdline
  ];
}
