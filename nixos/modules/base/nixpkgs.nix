{ pkgs, config, inputs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    config.boot.kernelPackages.cpupower
    git
    htop
    iotop
    nvtop
    powertop
    rsync
    vim
    (my-python.withPackages (p: with p; [
      cryptography
    ]))
  ];
}
