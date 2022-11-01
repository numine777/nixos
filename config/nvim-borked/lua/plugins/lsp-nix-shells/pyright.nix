{ pkgs ? import <nixpkgs> {} }:

with pkgs;
mkShell {
  buildInputs = [
    python310
    nodejs
    pyright
  ];
}
