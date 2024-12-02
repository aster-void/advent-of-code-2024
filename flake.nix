{
  description = "Advent of Code (solver) 2024";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        packages = {
          gleam = with pkgs; [ gleam erlang ];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [ packages.gleam ];
        };
      });
}
