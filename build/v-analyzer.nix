{ pkgs }:
let
  version = "0.0.5";
in
pkgs.stdenv.mkDerivation {
  pname = "v-analyzer";
  inherit version;
  src = pkgs.fetchFromGitHub {
    owner = "vlang";
    repo = "v-analyzer";
    rev = version;
    fetchSubmodules = true;
    hash = "sha256-uEvPnqRh+ZC+qjMlrWt3+nOBA3MUIa3TIboBS8A3UzY="; # change this on update
  };
  nativeBuildInputs = [ pkgs.vlang ];
  buildPhase = ''
    # prepare
    mkdir -p $out
    export HOME=/build # V uses this for something, apparently

    # build
    v build.vsh # FIXME: release build is not working
    # copy
    cp -r bin $out
  '';
}

