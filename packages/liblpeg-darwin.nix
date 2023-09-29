{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "liblpeg";
  inherit (pkgs.luajitPackages.lpeg) version src;

  nativeBuildInputs = [ pkgs.fixDarwinDylibNames ];
  buildInputs = [ pkgs.luajit ];

  patches = [ ../patches/liblpeg-makefile.patch ];

  installPhase = ''
    install -D lpeg.dylib $out/lib/lpeg.dylib
  '';

  meta = {
    homepage = "http://www.inf.puc-rio.br/~roberto/lpeg.html";
    description = "Parsing Expression Grammars For Lua";
    license.fullName = "MIT/X11";
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}
