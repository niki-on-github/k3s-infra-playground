{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    cmake
    gcc11
    pre-commit
    vagrant
    ansible
    ansible-lint
    nixpkgs-fmt
  ];
}
