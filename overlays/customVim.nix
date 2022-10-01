self: super:

let
  sources = import ../nix/sources.nix;
in
{
  customVim = with self; {
    cmp-tabnine = pkgs.vimPlugins.cmp-tabnine.overrideAttrs (oldAttrs: {
      buildInputs = [ pkgs.tabnine ];
      postFixup = ''
        mkdir -p $target/binaries/${pkgs.tabnine.version}
        ln -s ${pkgs.tabnine}/bin/ $target/binaries/${pkgs.tabnine.version}/${pkgs.tabnine.passthru.platform}
      '';
      src = sources."cmp-tabnine";
    });

    harpoon = pkgs.vimUtils.buildVimPlugin {
      name = "harpoon";
      src = sources."harpoon";
      buildInputs = [ pkgs.stylua ];
    };

    # Fix this some day
    git-worktree-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "git-worktree.nvim";
      src = sources."git-worktree.nvim";
      buildInputs = [ pkgs.stylua pkgs.neovim-nightly pkgs.vimPlugins.plenary-nvim pkgs.git ];
    };

    nvim-treesitter = pkgs.vimUtils.buildVimPlugin {
      name = "nvim-treesiter";
      src = sources."nvim-treesitter";
      buildInputs = [ tree-sitter curl git gcc ];
    };

    refactoring-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "refactoring.nvim";
      src = sources."refactoring.nvim";
      buildInputs = [ pkgs.stylua ];
      # buildInputs = [ pkgs.neovim-nightly pkgs.vimPlugins.plenary-nvim ];
    };

    xbase = pkgs.vimUtils.buildVimPlugin {
      name = "xbase";
      src = sources."xbase";
      buildInputs = [ pkgs.rustup ];
    };
    numine = pkgs.vimUtils.buildVimPlugin {
      name = "Numine777";
      src = ../config/nvim;
    };
  };
}
