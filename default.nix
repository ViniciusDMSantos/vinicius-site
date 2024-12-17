{ stdenv, lib, fetchFromGitHub, hugo, go, git }:

let
  theme = stdenv.mkDerivation rec {
    name = "theme";
    src = fetchFromGitHub {       
      owner = "adityatelange";
      repo = "hugo-PaperMod";
      rev = "3e53621";
      hash = "0zdpf3x1f2mhysczj1pa4ax05j8hh2vqljp6pbp6xlhak0d771hm";
    };
    installPhase = ''
      cp -r ./* $out/*
    '';
  };
in
stdenv.mkDerivation rec {
  name = "vinicius-site";
  src = ./.;

  buildInputs = [ hugo go ];

  buildPhase = ''
    cp -r ${theme} ./themes/PaperMod
    hugo
  '';

  installPhase = ''
    mkdir -p $out/public
    cp -r public/* -T $out/public
  '';
  
}
