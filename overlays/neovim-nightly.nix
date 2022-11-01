final: prev: rec {
  neovim-unwrapped = neovim-flake.packages.${prev.system}.neovim;
  neovim-nightly = neovim-flake.packages.${prev.system}.neovim;
  neovim-debug = neovim-flake.packages.${prev.system}.neovim-debug;
  neovim-developer = neovim-flake.packages.${prev.system}.neovim-developer;
}
