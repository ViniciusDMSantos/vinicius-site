{
  description = "Meu site (vinicius)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system}; 
        mkApp = drv: {
          type = "app";
          program = nixpkgs.lib.getExe drv;
        };
      in
      {
        packages = rec {
          vinicius-site = pkgs.callPackage ./default.nix {};
          default = vinicius-site;
        };
        apps = rec {
          default = serve;
          serve = mkApp (pkgs.writeShellScriptBin "serve" ''
            echo "Serving on http://localhost:8000"
            ${pkgs.webfs}/bin/webfsd -F -f index.html -r ${packages.default}/public
          '');
        };
      }
    );
}
