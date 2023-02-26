builtins.listToAttrs (builtins.map
  (path: {
    name = (builtins.replaceStrings [(toString ./.) "/" ".nix"]  ["modules" "-" ""] (toString path));
    value = import path;
  }) [
  ./base
  ./apps/server/k3s.nix
  ])
