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
          dev = with pkgs; [ just ];
          gleam = with pkgs; [ gleam erlang_27 nodejs-slim ];
          haskell = with pkgs; [ stack haskell-language-server ];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [ packages.dev packages.gleam packages.haskell ];
        };
      });
}
