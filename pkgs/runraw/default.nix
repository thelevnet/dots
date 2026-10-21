{ stdenv }:

stdenv.mkDerivation {
  pname = "runraw";
  version = "0.1.0";

  src = ./runraw.c;

  dontUnpack = true;

  buildPhase = ''
    $CC -O2 -o runraw $src
  '';

  installPhase = ''
    install -Dm755 runraw $out/bin/runraw
  '';
}
