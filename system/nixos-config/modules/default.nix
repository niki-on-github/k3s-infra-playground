builtins.listToAttrs (builtins.map
  (path: {
    name = (builtins.replaceStrings [(toString ./.) "/" ".nix"]  ["modules" "-" ""] (toString path));
    value = import path;
  }) [
  ./base
  ./boot
  ./apps/desktop
  ./apps/server/k3s.nix
  ./vm/qemu.nix
  ./desktop
  ./desktop/manager/kde
  ./desktop/manager/hyprland
  ./desktop/manager/sway
  ])
