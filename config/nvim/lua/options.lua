local o = vim.opt
local g = vim.g

o.relativenumber = true
o.clipboard = "unnamed"
o.timeoutlen = 500
o.shiftwidth = 4
o.tabstop = 4
o.showtabline = 1
o.laststatus = 3
o.splitbelow = true
o.splitright = true
o.eadirection = "hor"
o.fillchars = {
  vert = " ",
  fold = " ",
  eob = " ",
  diff = "░",
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "|",
  foldclose = "▸",
}
o.ignorecase = false
o.mouse = "a"
o.signcolumn = "yes"
o.cmdheight = 1
o.joinspaces = false -- No double spaces with join after a dot
o.list = true -- Show some invisible characters (tabs...
o.listchars = {
  tab = "| ",
  trail = "·",
}
o.expandtab = true -- use spaces when i press tab
o.smartindent = true --sentient indenting
o.hidden = true -- Enable modified buffers in background
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.undofile = true
o.undolevels = 10000
o.wildmode = "longest:full,full" -- Command-line completion mode
o.wrap = false -- Disable line wrap
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_localrmdir = "rm -rf"
g.mapleader = O.leader
-- markdown
-- Use proper syntax highlighting in code blocks
local fences = {
  "lua",
  "vim",
  "json",
  "typescript",
  "javascript",
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "python",
  "sh",
  "console=sh",
}
g.markdown_fenced_languages = fences

-- plasticboy/vim-markdown
g.vim_markdown_folding_level = 10
g.vim_markdown_fenced_languages = fences
g.vim_markdown_folding_style_pythonic = 1
g.vim_markdown_conceal_code_blocks = 0
g.vim_markdown_frontmatter = 1
g.vim_markdown_strikethrough = 1
