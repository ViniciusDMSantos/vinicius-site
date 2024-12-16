{ stdenv, lib, fetchFromGitHub, hugo, go, git }:

stdenv.mkDerivation rec {
  name = "vinicius-site";
  src = fetchFromGitHub {
    owner = "ViniciusDMSantos";
    repo = "vinicius-site";
    rev = "80e416f";
    sha256 = "sha256-tFBuCzzhKUXxhUniOmEvb+n3ebTxWp23U9tUWrWi3Pc=";
    fetchSubmodules = true;
  };

  buildInputs = [ hugo go git ];

  buildPhase = ''
    hugo
  '';

  installPhase = ''
    mkdir -p $out/public
    cp -r public -T $out/public
  '';

}