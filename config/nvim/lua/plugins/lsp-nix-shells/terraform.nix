{ pkgs ? import <nixpkgs> {} }:

with pkgs;
mkShell {
  buildInputs = [
    terraform
    terraform-ls
    tflint
  ];
}
