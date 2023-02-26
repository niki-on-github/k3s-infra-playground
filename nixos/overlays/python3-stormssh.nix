# see https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md
# TODO build based on my-python selection not python3
self: super:
{
  python3-stormssh = super.python3Packages.buildPythonPackage rec {
    pname = "stormssh";
    version = "0.7.0";

    src = super.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "8d034dcd9487fa0d280e0ec855d08420f51d5f9f2249f932e3c12119eaa53453";
    };

    propagatedBuildInputs = with super.python3Packages; [
      flask
      paramiko
      six
      termcolor
    ];

    # python3.10+ patch
    postPatch = ''
      substituteInPlace storm/kommandr.py --replace "collections.Callable" "collections.abc.Callable"
    '';

    nativeBuildInputs = [ super.python3Packages.pythonRelaxDepsHook ];
    pythonRelaxDeps = true;

    doCheck = false;
  };
}
