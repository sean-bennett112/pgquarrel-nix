{
  description = "A flake wrapping pgquarrel";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    pgquarrel-src = {
      url = "github:eulerto/pgquarrel";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, pgquarrel-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pgquarrel = pkgs.callPackage ./package.nix { src = pgquarrel-src; };
      in {
        overlay = final: prev: { inherit pgquarrel; };
        packages.pgquarrel = pgquarrel;
        defaultPackage = pgquarrel;
        devShell = pkgs.mkShell { buildInputs = [ pgquarrel ]; };
      });
}
