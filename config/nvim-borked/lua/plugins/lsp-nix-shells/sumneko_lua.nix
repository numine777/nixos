{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    sumneko-lua-language-server
    stylua
  ];
}
