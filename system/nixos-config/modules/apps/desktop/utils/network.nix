{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prettyping
    inetutils
    iw
    openvpn
    tcpdump
    update-systemd-resolved
  ];
}
