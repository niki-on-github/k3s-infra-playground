final: prev:
{
  k3s = (import (
    # use `https://lazamar.co.uk/nix-versions/?channel=nixos-unstable&package=k3s` to get Revision hash
    # use `nix-prefetch-url --unpack $TAR_URL` to get the sha256
    builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/73994921df2b89021c1cbded66e8f057a41568c1.tar.gz";
      sha256 = "1l2nzpm6yk3svgrkiii4r4zl3fxgx0hqwmy2y4cdvaq6s1c8qjq4";
    }) {
    system = "${prev.system}";
    config = { allowUnfree = true; };
  }).k3s;
}
