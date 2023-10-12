return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "nightly",   -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrodark",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false,    -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    local NumineGroup = augroup("Numine", {})

    local yank_group = augroup("HighlightYank", {})
    -- local ColorGroup = augroup("Colors", {})

    function R(name)
      require("plenary.reload").reload_module(name)
    end

    autocmd("TextYankPost", {
      group = yank_group,
      pattern = "*",
      callback = function()
        vim.highlight.on_yank({
          higroup = "IncSearch",
          timeout = 40,
        })
      end,
    })

    -- autocmd({ "BufEnter", "BufWinEnter", "TabEnter" }, {
    -- 	group = NumineGroup,
    -- 	pattern = "*.rs",
    -- 	callback = function()
    -- 		require("lsp_extensions").inlay_hints({})
    -- 	end,
    -- })

    autocmd({ "BufWritePre" }, {
      group = NumineGroup,
      pattern = "*",
      command = "%s/\\s\\+$//e",
    })

    autocmd({ "BufNewFile", "BufRead" }, {
      group = NumineGroup,
      pattern = "*Jenkinsfile",
      command = ":set ft=groovy",
    })

    autocmd({ "BufNewFile", "BufRead" }, {
      group = NumineGroup,
      pattern = "*.gradle",
      command = ":set ft=java",
    })

    autocmd({ "BufNewFile", "BufRead" }, {
      group = NumineGroup,
      pattern = { "*.bazel.tpl", "*.bzl*" },
      command = ":set ft=bzl",
    })

    autocmd({ "BufNewFile", "BufRead" }, {
      group = NumineGroup,
      pattern = "CMakeLists*",
      command = ":set ft=cmake",
    })

    autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { "Podfile", "Gemfile", "Gymfile", "Fastfile", "Appfile", "Matchfile", "Pluginfile" },
      command = ":set ft=ruby",
    })
    -- autocmd("ColorScheme", {
    --     group = ColorGroup,
    -- 	pattern = "*",
    -- 	callback = function()
    -- 		require("numine.colors").ColorMyPencils()
    -- 	end,
    -- })
  end,
}
