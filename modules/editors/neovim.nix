{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.editors.neovim;
in
{
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      stylua
      shellcheck
      black
      # python39Packages.isort
      rnix-lsp
      nixpkgs-fmt
      nil
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      nodePackages.prettier
      nodePackages.eslint
      ccls
      tree-sitter
    ];
    programs.neovim =
      {
        enable = true;
        package = pkgs.neovim-nightly;
        # plugins = with pkgs; [
          # vimPlugins.lazy-nvim
          # # languages
          # vimPlugins.nvim-lspconfig
          # vimPlugins.vim-nix

          # # treesitter
          # vimPlugins.nvim-treesitter

          # # completion
          # customVim.cmp-tabnine
          # customVim.copilot-lua
          # customVim.copilot-cmp
          # vimPlugins.cmp-buffer
          # vimPlugins.cmp-cmdline
          # vimPlugins.cmp-nvim-lsp
          # vimPlugins.cmp-path
          # vimPlugins.cmp-treesitter
          # vimPlugins.cmp-vsnip
          # vimPlugins.lspkind-nvim
          # vimPlugins.nvim-cmp
          # vimPlugins.vim-vsnip

          # # telescope
          # vimPlugins.plenary-nvim
          # vimPlugins.popup-nvim
          # vimPlugins.telescope-nvim

          # # theme
          # vimPlugins.gruvbox-community
          # vimPlugins.tokyonight-nvim

          # # extras
          # vimPlugins.neodev-nvim
          # vimPlugins.nvim-navic
          # vimPlugins.gitsigns-nvim
          # vimPlugins.lsp-colors-nvim
          # customVim.lir-nvim
          # customVim.rose-pine-nvim
          # vimPlugins.lualine-nvim
          # vimPlugins.comment-nvim
          # vimPlugins.nvim-treesitter-context
          # vimPlugins.nvim-web-devicons
          # vimPlugins.nvim-bqf
          # vimPlugins.fugitive
          # vimPlugins.undotree
          # customVim.harpoon
          # customVim.refactoring-nvim
          # customVim.git-conflict-nvim
          # # customVim.xbase
          # vimPlugins.symbols-outline-nvim
          # vimPlugins.luasnip
          # vimPlugins.null-ls-nvim
          # customVim.mason-nvim
          # customVim.git-worktree-nvim

        # ];
        extraConfig = ''
          if exists('g:vscode')
          " packadd quickscope

          execute 'luafile ' . stdpath('config') . '/lua/numine/sets.lua'

          function! s:manageEditorSize(...)
              let count = a:1
              let to = a:2
              for i in range(1, count ? count : 1)
                  call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
              endfor
          endfunction

          function! s:vscodeCommentary(...) abort
              if !a:0
                  let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
                  return 'g@'
              elseif a:0 > 1
                  let [line1, line2] = [a:1, a:2]
              else
                  let [line1, line2] = [line("'["), line("']")]
              endif

              call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
          endfunction

          function! s:openVSCodeCommandsInVisualMode()
              normal! gv
              let visualmode = visualmode()
              if visualmode == "V"
                  let startLine = line("v")
                  let endLine = line(".")
                  call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
              else
                  let startPos = getpos("v")
                  let endPos = getpos(".")
                  call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
              endif
          endfunction

          function! s:openWhichKeyInVisualMode()
              normal! gv
              let visualmode = visualmode()
              if visualmode == "V"
                  let startLine = line("v")
                  let endLine = line(".")
                  call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
              else
                  let startPos = getpos("v")
                  let endPos = getpos(".")
                  call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
              endif
          endfunction

          " Better Navigation
          "nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
          "xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
          "nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
          "xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
          "nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
          "xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
          "nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
          "xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
          nnoremap <silent> <C-h> :call VSCodeNotify('vscode-harpoon.gotoEditor1')<CR>
          nnoremap <silent> <C-t> :call VSCodeNotify('vscode-harpoon.gotoEditor2')<CR>
          nnoremap <silent> <C-n> :call VSCodeNotify('vscode-harpoon.gotoEditor3')<CR>
          nnoremap <silent> <C-s> :call VSCodeNotify('vscode-harpoon.gotoEditor4')<CR>
          nnoremap <silent> <C-e> :call VSCodeNotify('vscode-harpoon.editEditors')<CR>

          nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

          " Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
          xnoremap <expr> <C-/> <SID>vscodeCommentary()
          nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

          nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

          nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
          xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

          xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

          xmap gc  <Plug>VSCodeCommentary
          nmap gc  <Plug>VSCodeCommentary
          omap gc  <Plug>VSCodeCommentary
          nmap gcc <Plug>VSCodeCommentaryLine

          " Simulate same TAB behavior in VSCode
          nmap <Tab> :Tabnext<CR>
          nmap <S-Tab> :Tabprev<CR>

          else
            lua require("numine").init()
          endif
        '';
      };
    home.file.".config/nvim/after".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nvim/after";
    home.file.".config/nvim/lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/nvim/lua";
    home.file.".config/lvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/lvim";
  };
}
