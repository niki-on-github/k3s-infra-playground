{ stdenv, fetchgit, writeTextFile }:

let
  config_file = writeTextFile {
    name = "lone.plymouth";
    text = ''
      [Plymouth Theme]
      Name=lone
      Description=display kinda fireworks
      Comment=created By Aditya Shakya (@adi1090x)
      ModuleName=script

      [script]
      ImageDir=etc/plymouth/themes/lone
      ScriptFile=etc/plymouth/themes/lone/lone.script
    '';
  };
in
stdenv.mkDerivation rec {
  name = "lone";

  src = fetchGit {
    url = "https://github.com/adi1090x/plymouth-themes";
    rev = "bf2f570bee8e84c5c20caac353cbe1d811a4745f";
  };

  buildInputs = [ stdenv ];

  configurePhase = ''
    install_path=$out/share/plymouth/themes/
    mkdir -p $install_path
  '';

  buildPhase = ''
    substitute ${config_file} "pack_3/lone/lone.plymouth"
  '';

  installPhase = ''
    cd pack_3 && cp -r lone $install_path
  '';

  meta = with stdenv.lib; { platfotms = platforms.linux; };
}
