-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/scott/.cache/nvim/packer_hererocks/2.1.1693350652/share/lua/5.1/?.lua;/home/scott/.cache/nvim/packer_hererocks/2.1.1693350652/share/lua/5.1/?/init.lua;/home/scott/.cache/nvim/packer_hererocks/2.1.1693350652/lib/luarocks/rocks-5.1/?.lua;/home/scott/.cache/nvim/packer_hererocks/2.1.1693350652/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/scott/.cache/nvim/packer_hererocks/2.1.1693350652/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("Comment", {})' },
    keys = { { "", "<leader>c" }, { "", "gb" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip",
    wants = { "friendly-snippets" }
  },
  ["alpha-nvim"] = {
    config = { 'require("modules.ui.dashboard.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["ccc.nvim"] = {
    commands = { "CccPick", "CccHighlighterEnable", "CccHighlighterToggle" },
    config = { 'require("modules.tools.rgb.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/ccc.nvim",
    url = "https://github.com/uga-rosa/ccc.nvim"
  },
  ["clangd_extensions.nvim"] = {
    config = { 'require("modules.lang.cc.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/clangd_extensions.nvim",
    url = "https://github.com/p00f/clangd_extensions.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-conjure"] = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-conjure/after/plugin/cmp_conjure.lua" },
    load_after = {
      conjure = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-conjure",
    url = "https://github.com/PaterJason/cmp-conjure"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help/after/plugin/cmp_nvim_lsp_signature_help.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  conjure = {
    after = { "cmp-conjure" },
    config = { 'require("modules.tools.eval.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/conjure",
    url = "https://github.com/Olical/conjure"
  },
  ["copilot-cmp"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    config = { 'require("modules.completion.copilot.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["crates.nvim"] = {
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("crates", {})' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  ["editor.scratch"] = {
    commands = { "Scratch" },
    config = { 'require("modules.editor.scratch.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/editor.scratch",
    url = "https://github.com/editor.scratch"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { 'require("modules.ui.vc-gutter.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hotpot.nvim"] = {
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/hotpot.nvim",
    url = "https://github.com/rktjmp/hotpot.nvim"
  },
  ["hydra.nvim"] = {
    config = { 'require("modules.ui.hydra.config")' },
    keys = { { "", "<leader>g" }, { "", "<leader>v" }, { "", "<leader>f" }, { "", "<leader>d" }, { "", "<leader>m" }, { "", "<leader>t" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/hydra.nvim",
    url = "https://github.com/anuvyklack/hydra.nvim"
  },
  ["leap-ast.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/leap-ast.nvim",
    url = "https://github.com/ggandor/leap-ast.nvim"
  },
  ["leap.nvim"] = {
    config = { 'require("modules.config.default.+bindings.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_lines.nvim"] = {
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("lsp_lines", {})' },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["mason.nvim"] = {
    commands = { "Mason", "MasonLog" },
    config = { 'require("modules.tools.mason.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["modes.nvim"] = {
    config = { 'require("modules.ui.nyoom.+modes.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/modes.nvim",
    url = "https://github.com/mvllow/modes.nvim"
  },
  ["nabla.nvim"] = {
    config = { 'require("modules.lang.neorg.+nabla.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nabla.nvim",
    url = "https://github.com/jbyuki/nabla.nvim"
  },
  neorg = {
    commands = { "Neorg" },
    config = { 'require("modules.lang.neorg.config")' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["nim.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nim.nvim",
    url = "https://github.com/alaviss/nim.nvim"
  },
  ["noice.nvim"] = {
    config = { 'require("modules.ui.noice.config")' },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { 'require("modules.checkers.diagnostics.config")' },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    after = { "cmp_luasnip", "cmp-nvim-lsp", "cmp-nvim-lsp-signature-help", "cmp-buffer", "cmp-cmdline", "cmp-path" },
    config = { 'require("modules.completion.cmp.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp",
    wants = { "LuaSnip" }
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui", "nvim-dap-python" },
    config = { 'require("modules.tools.debugger.config")' },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/rcarriga/nvim-dap"
  },
  ["nvim-dap-python"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dev-container"] = {
    commands = { "DevcontainerBuild", "DevcontainerImageRun", "DevcontainerBuildAndRun", "DevcontainerBuildRunAndAttach", "DevcontainerComposeUp", "DevcontainerComposeDown", "DevcontainerComposeRm", "DevcontainerStartAuto", "DevcontainerStartAutoAndAttach", "DevcontainerAttachAuto", "DevcontainerStopAuto", "DevcontainerStopAll", "DevcontainerRemoveAll", "DevcontainerLogs", "DevcontainerOpenNearestConfig", "DevcontainerEditNearestConfig" },
    config = { 'require("modules.tools.docker.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-dev-container",
    url = "https://codeberg.org/esensar/nvim-dev-container"
  },
  ["nvim-jdtls"] = {
    config = { 'require("modules.lang.java.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    after = { "noice.nvim", "null-ls.nvim", "lsp_lines.nvim" },
    config = { 'require("modules.tools.lsp.config")' },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-material-icon"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-material-icon",
    url = "https://github.com/DaikyXendo/nvim-material-icon"
  },
  ["nvim-notify"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-parinfer-rust"] = {
    config = { 'require("modules.editor.parinfer.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-parinfer-rust",
    url = "https://github.com/harrygallagher4/nvim-parinfer-rust"
  },
  ["nvim-pqf"] = {
    commands = { "copen", "cclose" },
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("nvim-pqf", {})' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-pqf",
    url = "https://github.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle" },
    config = { 'require("modules.ui.nvimtree.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ufo" },
    commands = { "TSInstall", "TSUpdate", "TSInstallSync", "TSUpdateSync", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    config = { 'require("modules.tools.tree-sitter.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow2"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow2",
    url = "https://github.com/HiPhish/nvim-ts-rainbow2"
  },
  ["nvim-ufo"] = {
    config = { 'require("modules.editor.fold.config")' },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    config = { 'require("modules.ui.nyoom.+icons.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { 'require("modules.ui.window-select.config")' },
    keys = { { "", "<space>w" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  nvlime = {
    after_files = { "/home/scott/.local/share/nvim/site/pack/packer/opt/nvlime/after/plugin/cmp_nvlime.lua" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/nvlime",
    url = "https://github.com/monkoose/nvlime"
  },
  ["nyoom.5e06be48"] = {
    config = { 'require("modules.tools.antifennel.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/nyoom.5e06be48",
    url = "https://github.com/nyoom.5e06be48"
  },
  ["nyoom.5ea6febe"] = {
    config = { 'require("modules.ui.modeline.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/nyoom.5ea6febe",
    url = "https://github.com/nyoom.5ea6febe"
  },
  ["nyoom.8af4af0e"] = {
    config = { 'require("modules.config.default.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/nyoom.8af4af0e",
    url = "https://github.com/nyoom.8af4af0e"
  },
  ["nyoom.bc4ecd1d"] = {
    config = { 'require("modules.editor.word-wrap.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/nyoom.bc4ecd1d",
    url = "https://github.com/nyoom.bc4ecd1d"
  },
  ["nyoom.ce9ac7f6"] = {
    config = { 'require("modules.editor.hotpot.+reflect.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/nyoom.ce9ac7f6",
    url = "https://github.com/nyoom.ce9ac7f6"
  },
  ["nyoom.e69e8fc3"] = {
    config = { 'require("modules.editor.format.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/nyoom.e69e8fc3",
    url = "https://github.com/nyoom.e69e8fc3"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["oxocarbon.nvim"] = {
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/oxocarbon.nvim",
    url = "https://github.com/nyoom-engineering/oxocarbon.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["paperplanes.nvim"] = {
    commands = { "PP" },
    config = { 'require("modules.tools.pastebin.config")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/paperplanes.nvim",
    url = "https://github.com/rktjmp/paperplanes.nvim"
  },
  ["parinfer-rust"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/parinfer-rust",
    url = "https://github.com/eraserhd/parinfer-rust"
  },
  playground = {
    commands = { "TSPlayground" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["promise-async"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["rust-tools.nvim"] = {
    config = { 'require("modules.lang.rust.config")' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope-tabs"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-tabs",
    url = "https://github.com/LukasPietzschmann/telescope-tabs"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope-zoxide"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope-zoxide",
    url = "https://github.com/jvgrootveld/telescope-zoxide"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { 'require("modules.completion.telescope.config")' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-lua/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "ToggleTerm" },
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("toggleterm", {})' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble" },
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("trouble", {})' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["true-zen.nvim"] = {
    commands = { "TZAtaraxis", "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
    config = { 'require("core.lib.autoload")["autoload"]("core.lib.setup")["setup"]("true-zen", {})' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/true-zen.nvim",
    url = "https://github.com/Pocco81/true-zen.nvim"
  },
  ["vim-fugitive"] = {
    config = { 'require("modules.tools.fugitive.config")' },
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/scott/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["which-key.nvim"] = {
    config = { 'require("modules.config.default.+which-key.config")' },
    keys = { { "", "<leader>" }, { "", '"' }, { "", "'" }, { "", "`" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/scott/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp"] = "nvim-cmp",
  ["^gitsigns"] = "gitsigns.nvim",
  ["^hydra"] = "hydra.nvim",
  ["^nui"] = "nui.nvim",
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^plenary"] = "plenary.nvim",
  ["^telescope"] = "telescope.nvim",
  ["^which%-key"] = "which-key.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: nvim-treesitter
time([[Setup for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nh\0\0\3\0\a\0\0156\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\6\0\4\0X\1\4€\6\0\5\0X\1\2€\a\0\6\0X\1\2€+\1\1\0X\2\1€+\1\2\0L\1\2\0\5\r[packer]\15NvimTree_1\6%\vexpand\afn\bvim \1\1\0\4\0\b\0\0203\0\0\0\15\0\0\0X\1\r€6\1\1\0009\1\2\0019\1\3\1'\3\4\0B\1\2\0016\1\5\0'\3\6\0B\1\2\0029\1\a\1'\3\4\0002\0\0€D\1\2\0X\1\3€+\1\0\0002\0\0€L\1\2\0K\0\1\0\vloader\vpacker\rautoload\20nvim-treesitter\29nvim_del_augroup_by_name\bapi\bvim\0¦\1\1\0\t\0\n\0\0163\0\0\0006\1\1\0009\1\2\0019\1\3\0015\3\4\0005\4\a\0006\5\1\0009\5\2\0059\5\5\5'\a\6\0004\b\0\0B\5\3\2=\5\b\4=\0\t\0042\0\0€D\1\3\0\rcallback\ngroup\1\0\0\20nvim-treesitter\24nvim_create_augroup\1\2\0\0\fBufRead\24nvim_create_autocmd\bapi\bvim\0\0", "setup", "nvim-treesitter")
time([[Setup for nvim-treesitter]], false)
-- Setup for: nvim-dap
time([[Setup for nvim-dap]], true)
try_loadstring("\27LJ\2\n'\0\3\4\0\0\0\b\5\0\1\0X\3\4€\5\1\2\0X\3\2€+\3\1\0X\4\1€+\3\2\0L\3\2\0•\1\0\0\3\0\b\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1'\0\4\0\a\0\3\0X\0\5€6\0\5\0009\0\6\0'\2\a\0D\0\2\0X\0\2€+\0\0\0L\0\2\0K\0\1\0\24silent! do FileType\bcmd\bvim\19nvim-lspconfig\rnvim-dap\vloader\vpacker\frequirew\1\0\5\0\b\0\0213\0\0\0006\2\1\0009\2\2\0029\2\3\2'\3\4\0'\4\5\0B\0\4\2\15\0\0\0X\1\b€3\0\6\0006\1\1\0009\1\a\1\18\3\0\0)\4\0\0002\0\0€D\1\3\0X\0\3€+\0\0\0002\0\0€L\0\2\0K\0\1\0\rdefer_fn\0\5\6%\vexpand\afn\bvim\0¶\1\1\0\t\0\n\0\0163\0\0\0006\1\1\0009\1\2\0019\1\3\0015\3\4\0005\4\5\0=\0\6\0046\5\1\0009\5\2\0059\5\a\5'\a\b\0004\b\0\0B\5\3\2=\5\t\0042\0\0€D\1\3\0\ngroup\rnvim-dap\24nvim_create_augroup\rcallback\1\0\0\1\4\0\0\fBufRead\16BufWinEnter\15BufNewFile\24nvim_create_autocmd\bapi\bvim\0\0", "setup", "nvim-dap")
time([[Setup for nvim-dap]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\4\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0D\0\2\0\18gitsigns.nvim\vloader\vpacker\frequire¾\1\1\0\6\0\v\1\0286\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3'\5\5\0B\3\2\2'\4\6\0&\2\4\2B\0\2\0016\0\0\0009\0\a\0009\0\b\0\t\0\0\0X\0\a€3\0\t\0006\1\0\0009\1\n\1\18\3\0\0002\0\0€D\1\2\0X\0\3€+\0\0\0002\0\0€L\0\2\0K\0\1\0\rschedule\0\16shell_error\6v\15 rev-parse\n%:p:h\vexpand\fgit -C \vsystem\afn\bvim\0\20\1\0\1\0\1\0\0033\0\0\0002\0\0€L\0\2\0\0¡\2\1\0\5\0\a\0\t3\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0005\4\5\0=\0\6\0042\0\0€D\1\3\0\rcallback\1\0\2\fpattern\6*\tdesc¹\1'(fn [] (vim.fn.system (.. \"git -C \" (vim.fn.expand \"%:p:h\") \" rev-parse\")) (when (= vim.v.shell_error 0) (vim.schedule (fn [] ((. (require \"packer\") \"loader\") \"gitsigns.nvim\")))))\fBufRead\24nvim_create_autocmd\bapi\bvim\0\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: nvim-lspconfig
time([[Setup for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n'\0\3\4\0\0\0\b\5\0\1\0X\3\4€\5\1\2\0X\3\2€+\3\1\0X\4\1€+\3\2\0L\3\2\0Œ\1\0\0\3\0\a\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1'\0\3\0\a\0\3\0X\0\5€6\0\4\0009\0\5\0'\2\6\0D\0\2\0X\0\2€+\0\0\0L\0\2\0K\0\1\0\24silent! do FileType\bcmd\bvim\19nvim-lspconfig\vloader\vpacker\frequirew\1\0\5\0\b\0\0213\0\0\0006\2\1\0009\2\2\0029\2\3\2'\3\4\0'\4\5\0B\0\4\2\15\0\0\0X\1\b€3\0\6\0006\1\1\0009\1\a\1\18\3\0\0)\4\0\0002\0\0€D\1\3\0X\0\3€+\0\0\0002\0\0€L\0\2\0K\0\1\0\rdefer_fn\0\5\6%\vexpand\afn\bvim\0¼\1\1\0\t\0\n\0\0163\0\0\0006\1\1\0009\1\2\0019\1\3\0015\3\4\0005\4\5\0=\0\6\0046\5\1\0009\5\2\0059\5\a\5'\a\b\0004\b\0\0B\5\3\2=\5\t\0042\0\0€D\1\3\0\ngroup\19nvim-lspconfig\24nvim_create_augroup\rcallback\1\0\0\1\4\0\0\fBufRead\16BufWinEnter\15BufNewFile\24nvim_create_autocmd\bapi\bvim\0\0", "setup", "nvim-lspconfig")
time([[Setup for nvim-lspconfig]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
require("modules.tools.fugitive.config")
time([[Config for vim-fugitive]], false)
-- Config for: nyoom.bc4ecd1d
time([[Config for nyoom.bc4ecd1d]], true)
require("modules.editor.word-wrap.config")
time([[Config for nyoom.bc4ecd1d]], false)
-- Config for: nyoom.5e06be48
time([[Config for nyoom.5e06be48]], true)
require("modules.tools.antifennel.config")
time([[Config for nyoom.5e06be48]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
require("modules.config.default.+bindings.config")
time([[Config for leap.nvim]], false)
-- Config for: nyoom.ce9ac7f6
time([[Config for nyoom.ce9ac7f6]], true)
require("modules.editor.hotpot.+reflect.config")
time([[Config for nyoom.ce9ac7f6]], false)
-- Config for: nyoom.8af4af0e
time([[Config for nyoom.8af4af0e]], true)
require("modules.config.default.config")
time([[Config for nyoom.8af4af0e]], false)
-- Config for: nyoom.e69e8fc3
time([[Config for nyoom.e69e8fc3]], true)
require("modules.editor.format.config")
time([[Config for nyoom.e69e8fc3]], false)
-- Config for: nyoom.5ea6febe
time([[Config for nyoom.5ea6febe]], true)
require("modules.ui.modeline.config")
time([[Config for nyoom.5ea6febe]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
require("modules.ui.dashboard.config")
time([[Config for alpha-nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'CccHighlighterEnable', function(cmdargs)
          require('packer.load')({'ccc.nvim'}, { cmd = 'CccHighlighterEnable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'ccc.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CccHighlighterEnable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'CccHighlighterToggle', function(cmdargs)
          require('packer.load')({'ccc.nvim'}, { cmd = 'CccHighlighterToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'ccc.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CccHighlighterToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Mason', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'Mason', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Mason ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'copen', function(cmdargs)
          require('packer.load')({'nvim-pqf'}, { cmd = 'copen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-pqf'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('copen ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'cclose', function(cmdargs)
          require('packer.load')({'nvim-pqf'}, { cmd = 'cclose', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-pqf'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('cclose ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeToggle', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ToggleTerm', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'ToggleTerm', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ToggleTerm ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerBuild', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerBuild', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerBuild ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerImageRun', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerImageRun', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerImageRun ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSInstall', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSInstall', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSInstall ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerLogs', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerLogs', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerLogs ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerBuildAndRun', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerBuildAndRun', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerBuildAndRun ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSUpdate', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSUpdate', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSUpdate ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerBuildRunAndAttach', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerBuildRunAndAttach', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerBuildRunAndAttach ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Scratch', function(cmdargs)
          require('packer.load')({'editor.scratch'}, { cmd = 'Scratch', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'editor.scratch'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Scratch ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSUpdateSync', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSUpdateSync', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSUpdateSync ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerEditNearestConfig', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerEditNearestConfig', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerEditNearestConfig ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSBufEnable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSBufEnable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSBufEnable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TZAtaraxis', function(cmdargs)
          require('packer.load')({'true-zen.nvim', 'true-zen.nvim'}, { cmd = 'TZAtaraxis', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'true-zen.nvim', 'true-zen.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TZAtaraxis ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerComposeRm', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerComposeRm', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerComposeRm ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSBufDisable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSBufDisable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSBufDisable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Telescope', function(cmdargs)
          require('packer.load')({'telescope.nvim'}, { cmd = 'Telescope', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'telescope.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Telescope ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSEnable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSEnable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSEnable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerStartAutoAndAttach', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerStartAutoAndAttach', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerStartAutoAndAttach ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSDisable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSDisable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSDisable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerAttachAuto', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerAttachAuto', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerAttachAuto ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSModuleInfo', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSModuleInfo', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSModuleInfo ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerStopAuto', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerStopAuto', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerStopAuto ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerStopAll', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerStopAll', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerStopAll ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerRemoveAll', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerRemoveAll', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerRemoveAll ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerOpenNearestConfig', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerOpenNearestConfig', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerOpenNearestConfig ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSPlayground', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSPlayground', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSPlayground ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerStartAuto', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerStartAuto', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerStartAuto ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerComposeDown', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerComposeDown', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerComposeDown ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'DevcontainerComposeUp', function(cmdargs)
          require('packer.load')({'nvim-dev-container'}, { cmd = 'DevcontainerComposeUp', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-dev-container'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DevcontainerComposeUp ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSInstallSync', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSInstallSync', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSInstallSync ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'PP', function(cmdargs)
          require('packer.load')({'paperplanes.nvim'}, { cmd = 'PP', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'paperplanes.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('PP ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Trouble', function(cmdargs)
          require('packer.load')({'trouble.nvim'}, { cmd = 'Trouble', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'trouble.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Trouble ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'MasonLog', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'MasonLog', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('MasonLog ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TZFocus', function(cmdargs)
          require('packer.load')({'true-zen.nvim'}, { cmd = 'TZFocus', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'true-zen.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TZFocus ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TZMinimalist', function(cmdargs)
          require('packer.load')({'true-zen.nvim'}, { cmd = 'TZMinimalist', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'true-zen.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TZMinimalist ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'CccPick', function(cmdargs)
          require('packer.load')({'ccc.nvim'}, { cmd = 'CccPick', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'ccc.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CccPick ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Neorg', function(cmdargs)
          require('packer.load')({'neorg'}, { cmd = 'Neorg', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'neorg'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Neorg ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TZNarrow', function(cmdargs)
          require('packer.load')({'true-zen.nvim'}, { cmd = 'TZNarrow', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'true-zen.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TZNarrow ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <space>w <cmd>lua require("packer.load")({'nvim-window-picker'}, { keys = "<lt>space>w", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ` <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "`", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ' <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "'", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> " <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "\"", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader> <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "<lt>leader>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gb <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>f <cmd>lua require("packer.load")({'hydra.nvim'}, { keys = "<lt>leader>f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>g <cmd>lua require("packer.load")({'hydra.nvim'}, { keys = "<lt>leader>g", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>c <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>c", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>v <cmd>lua require("packer.load")({'hydra.nvim'}, { keys = "<lt>leader>v", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>m <cmd>lua require("packer.load")({'hydra.nvim'}, { keys = "<lt>leader>m", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>d <cmd>lua require("packer.load")({'hydra.nvim'}, { keys = "<lt>leader>d", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>t <cmd>lua require("packer.load")({'hydra.nvim'}, { keys = "<lt>leader>t", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType gitcommit ++once lua require("packer.load")({'gitsigns.nvim'}, { ft = "gitcommit" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'nvim-parinfer-rust', 'conjure'}, { ft = "fennel" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'conjure'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'nvim-parinfer-rust', 'conjure'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'nvim-jdtls'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType julia ++once lua require("packer.load")({'conjure'}, { ft = "julia" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType scheme ++once lua require("packer.load")({'nvim-parinfer-rust'}, { ft = "scheme" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'nvim-parinfer-rust', 'nvlime', 'conjure'}, { ft = "lisp" }, _G.packer_plugins)]]
vim.cmd [[au FileType janet ++once lua require("packer.load")({'nvim-parinfer-rust'}, { ft = "janet" }, _G.packer_plugins)]]
vim.cmd [[au FileType guile ++once lua require("packer.load")({'nvim-parinfer-rust'}, { ft = "guile" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'conjure'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex', 'nabla.nvim'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType bib ++once lua require("packer.load")({'vimtex'}, { ft = "bib" }, _G.packer_plugins)]]
vim.cmd [[au FileType norg ++once lua require("packer.load")({'nabla.nvim', 'neorg'}, { ft = "norg" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'clangd_extensions.nvim'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'conjure', 'rust-tools.nvim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType racket ++once lua require("packer.load")({'nvim-parinfer-rust'}, { ft = "racket" }, _G.packer_plugins)]]
vim.cmd [[au FileType nim ++once lua require("packer.load")({'nim.nvim'}, { ft = "nim" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead Cargo.toml ++once lua require("packer.load")({'crates.nvim'}, { event = "BufRead Cargo.toml" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'copilot.lua', 'modes.nvim', 'LuaSnip', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CmdLineEnter * ++once lua require("packer.load")({'LuaSnip', 'nvim-cmp'}, { event = "CmdLineEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CmdlineEnter * ++once lua require("packer.load")({'noice.nvim'}, { event = "CmdlineEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/nim.nvim/ftdetect/nim.vim]], true)
vim.cmd [[source /home/scott/.local/share/nvim/site/pack/packer/opt/nim.nvim/ftdetect/nim.vim]]
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/nim.nvim/ftdetect/nim.vim]], false)
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.lua]], true)
vim.cmd [[source /home/scott/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.lua]]
time([[Sourcing ftdetect script at: /home/scott/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.lua]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
