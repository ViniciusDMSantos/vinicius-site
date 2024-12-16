{ stdenv, lib, fetchFromGitHub, hugo, go, git }:

stdenv.mkDerivation rec {
  name = "vinicius-site";
  src = ./.;

  buildInputs = [ hugo go git ];

  buildPhase = ''
    hugo
  '';

  installPhase = ''
    mkdir -p $out/public
    cp -r public -T $out/public
  '';

}
