{
  description = "Meu site (vinicius)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };


  outputs = { self, nixpkgs }:

  let
    supportedSystems = [ "x86_64-linux" ];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

    pkgs = nixpkgsFor.${system};

    mkApp = drv: {
      type = "app";
      program = nixpkgs.lib.getExe drv;
  };
  in rec {
    packages = forAllSystems (system: {
        default = vinicius-site;
        vinicius-site = pkgs.callPackage ./default.nix {};
    });

    apps = forAllSystems (system: {
      default = serve;
      serve = mkApp (pkgs.writeShellScriptBin "serve" ''
        echo "Serving on http://localhost:8000"
        ${pkgs.webfs}/bin/webfsd -F -f index.html -r ${packages.default}/public
      '');

    });

  };

}
