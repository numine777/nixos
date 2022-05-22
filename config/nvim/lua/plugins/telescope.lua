local telescope = require "telescope"
local utils = require "utils"
local a = require "telescope.actions"
local b = require "telescope.builtin"
local x = telescope.extensions
local l = telescope.load_extension

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-c>"] = a.close,
                ["<esc>"] = a.close,
                ["<c-s>"] = a.select_horizontal,
                ["<c-j>"] = a.cycle_history_next,
                ["<c-k>"] = a.cycle_history_prev,
            },
            n = {
                ["<C-q>"] = a.smart_send_to_qflist + a.open_qflist,
            }
        },
        file_ignore_patterns = {
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.otf",
            "%.ttf",
            "node_modules",
            ".git",
        },
        layout_strategy = "flex",
        layout_config = {
            horizontal = {
                preview_width = 0.6,
            },
        },
        -- winblend = 30,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        extensions = {
            -- frecency = {
            --   workspaces = {
            --     dotfiles = "$HOME/dotfiles",
            --     projects = "$HOME/projects",
            --     dwm = "$HOME/projects/dwm",
            --     site = "$HOME/projects/site",
            --   },
            -- },
            -- fzf = {
            --     override_generic_sorter = true, -- override the generic sorter
            --     override_file_sorter = true, -- override the file sorter
            -- },
        },
    },
}

-- l "fzf"
l "file_browser"
l "live_grep_raw"
l "git_worktree"

local function grep()
    x.live_grep_raw.live_grep_raw {
        path_display = { "shorten" },
        only_sort_text = true,
        use_regex = true,
    }
end

local function ivy()
    vim.cmd [[ set laststatus=0 ]]
    b.find_files {
        previewer = false,
        sorting_strategy = "ascending",
        preview_title = "",
        layout_strategy = "bottom_pane",
        layout_config = {
            height = 8,
        },
        border = true,
        borderchars = {
            "z",
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
        },
    }
    vim.cmd [[ set laststatus=2 ]]
end

local function browse_files()
    vim.cmd [[ set laststatus=0 ]]
    x.file_browser.file_browser {
        previewer = false,
        sorting_strategy = "ascending",
        preview_title = "",
        layout_strategy = "bottom_pane",
        layout_config = {
            height = 10,
        },
        border = true,
        borderchars = { "" },
    }
    vim.cmd [[ set laststatus=2 ]]
end

local function buffers()
    vim.cmd [[ set laststatus=0 ]]
    b.buffers {
        previewer = false,
        sorting_strategy = "ascending",
        preview_title = "",
        layout_strategy = "bottom_pane",
        layout_config = {
            height = 7,
        },
        border = true,
        borderchars = {
            "z",
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
        },
    }
    vim.cmd [[ set laststatus=2 ]]
end

local function search_dotfiles()
    b.find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end

local function lsp_code_actions()
    b.lsp_code_actions {
        sorting_strategy = "ascending",
        results_title = false,
        layout_strategy = "cursor",
        layout_config = {
            width = 70,
            height = 10,
        },
        borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
    }
end

utils.nnoremap("<leader>f", b.find_files, {})
utils.nnoremap("<leader>sd", search_dotfiles, {})
utils.nnoremap("<leader>st", grep, {})
utils.nnoremap("<leader>sh", b.help_tags, {})
utils.nnoremap("<leader>sm", b.man_pages, {})
utils.nnoremap("<leader>gw", x.git_worktree.git_worktrees, {})
utils.nnoremap("<leader>gm", x.git_worktree.create_git_worktree, {})
--   ["<leader>"] = {
--     -- find
--     f = {
--       name = "+find",
--       f = { b.find_files, "files" },
--       -- r = { x.frecency.frecency, "frecent files" },
--       w = { grep, "grep" },
--       b = { b.current_buffer_fuzzy_find, "find in buffer" },
--       m = { b.man_pages, "man pages" },
--       h = { b.help_tags, "help" },
--       i = { ivy, "ivy" },
--       g = {
--         name = "+git",
--         f = { b.git_files, "files" },
--         b = { b.git_branches, "branches" },
--         c = { b.git_commits, "commits" },
--         s = { b.git_status, "status" },
--         S = { b.git_stash, "stash" },
--       },
--       l = {
--         name = "+lsp",
--         d = { b.lsp_definitions, "definitions" },
--         r = { b.references, "references" },
--         i = { b.lsp_implementations, "implementations" },
--         s = { b.lsp_document_symbols, "document symbols" },
--         w = { b.lsp_workspace_symbols, "workspace symbols" },
--       },
--     },
--   },
--   ["<M-f>"] = { ivy, "find files" },
--   ["<M-b>"] = { browse_files, "browse files" },
--   ["<M-s>"] = { buffers, "switch buffer" },
-- }

return { lsp_code_actions = lsp_code_actions }
