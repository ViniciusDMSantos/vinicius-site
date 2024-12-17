{ stdenv, lib, fetchFromGitHub, hugo, go, git }:

let
  theme = stdenv.mkDerivation rec {
    name = "theme";
    src = fetchFromGitHub {       
      owner = "adityatelange";
      repo = "hugo-PaperMod";
      rev = "3e53621";
      sha256 = "sha256-Dv/QnYYG5KTQro95kzwgQeOS0nO2HyfBoSou5AsCFAI=";
    };
    installPhase = ''
      cp -r ./. $out/
    '';
  };
in
stdenv.mkDerivation rec {
  name = "vinicius-site";
  src = ./.;

  buildInputs = [ hugo go ];

  buildPhase = ''
    mkdir -p ./themes/PaperMod
    cp -r ${theme}/* ./themes/PaperMod
    hugo
  '';

  installPhase = ''
    mkdir -p $out/public
    cp -r public/ -T $out/public
  '';
  
}
