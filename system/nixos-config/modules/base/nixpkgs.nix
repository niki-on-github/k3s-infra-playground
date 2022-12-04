{ pkgs, inputs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    git
    htop
    rsync
    vim
    (my-python.withPackages (p: with p; [
      cryptography
    ]))
  ];
}
