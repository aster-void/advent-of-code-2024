{ pkgs ? import <nixpkgs> { } }:
let
  v-analyzer = import ./v-analyzer.nix { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = [
    v-analyzer
  ];
}
