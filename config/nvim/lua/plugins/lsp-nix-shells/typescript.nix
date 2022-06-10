{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  buildInputs = with pkgs; [
    (with nodePackages;[
      node2nix
      nodejs-16_x
      eslint
      typescript
      pyright
      prettier
      bashInteractive
      bash-language-server
      dockerfile-language-server-nodejs
      vscode-css-languageserver-bin
      vscode-html-languageserver-bin
      typescript-language-server
      terraform
      terraform-ls
      tflint
    ])
  ]; # end of buildInputs
  shellHook = ''
    zsh
  '';
} # end of mkShell
