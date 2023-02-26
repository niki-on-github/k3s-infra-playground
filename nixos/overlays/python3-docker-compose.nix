# see https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md
# TODO build based on my-python selection not python3
self: super:
{
  python3-docker-compose = super.python3Packages.buildPythonPackage rec {
    pname = "docker-compose";
    version = "1.29.2";

    src = super.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "4c8cd9d21d237412793d18bd33110049ee9af8dab3fe2c213bbd0733959b09b7";
    };

    propagatedBuildInputs = with super.python3Packages; [
      distro
      docker
      dockerpty
      docopt
      jsonschema_3
      paramiko
      python-dotenv
      pyyaml
      requests
      texttable
      websocket-client
    ];

    nativeBuildInputs = [ super.python3Packages.pythonRelaxDepsHook ];
    pythonRelaxDeps = true;

    doCheck = false;
  };
}
