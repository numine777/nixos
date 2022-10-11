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
      buildInputs = [ pkgs.cargo pkgs.rustc ];
    };

    lir-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "lir.nvim";
      src = sources."lir.nvim";
      buildInputs = [ pkgs.stylua pkgs.luaPackages.luacheck ];
    };

    git-conflict-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "git-conflict.nvim";
      src = sources."git-conflict.nvim";
      buildInputs = [ pkgs.stylua pkgs.luaPackages.luacheck ];
    };

    neotest = pkgs.vimUtils.buildVimPlugin {
      name = "neotest";
      src = sources."neotest";
      buildInputs = [ pkgs.stylua pkgs.luaPackages.luacheck ];
    };

    mason-lspconfig-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "mason-lspconfig.nvim";
      src = sources."mason-lspconfig.nvim";
      buildInputs = [ pkgs.git pkgs.curl pkgs.neovim-nightly ];
      # buildInputs = [ (pkgs.neovim.override {
      #   configure = {
      #     packages.myPlugins = with pkgs; {
      #       start = [ vimPlugins.plenary-nvim vimPlugins.nvim-lspconfig customVim.neotest customVim.mason-nvim ];
      #     };
      #   };
      # }) pkgs.git pkgs.curl ];
    };

    mason-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "mason.nvim";
      src = sources."mason.nvim";
      buildInputs = [ pkgs.git pkgs.curl pkgs.neovim-nightly ];
      # buildInputs = [ (pkgs.neovim.override {
      #   configure = {
      #     packages.myPlugins = with pkgs; {
      #       start = [ vimPlugins.plenary-nvim customVim.neotest customVim.mason-lspconfig-nvim ];
      #     };
      #   };
      # }) pkgs.git pkgs.curl ];
    };

    numine = pkgs.vimUtils.buildVimPlugin {
      name = "Numine777";
      src = ../config/nvim;
    };
  };
}
