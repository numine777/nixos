--[[

      enrich_config = function(config, on_config)
        local final_config = vim.deepcopy(config)
        final_config.extra_property = 'This got injected by the adapter'
        on_config(final_config)
      end;

--]]

local Job = require "plenary.job"
local dap = require "dap"

local M = {}

--[[
|| {
||   args = {
||     cargoArgs = { "test", "--package", "dap-tester", "--bin", "dap-tester" },
||     cargoExtraArgs = {},
||     executableArgs = { "test::can_i_debug_this", "--exact", "--nocapture" },
||     workspaceRoot = "/home/tjdevries/tmp/dap-tester"
||   },
||   kind = "cargo",
||   label = "test test::can_i_debug_this",
||   location = {
||     targetRange = {
||       end = {
||         character = 5,
||         line = 22
||       },
||       start = {
||         character = 4,
||         line = 14
||       }
||     },
||     targetSelectionRange = {
||       end = {
||         character = 23,
||         line = 15
||       },
||       start = {
||         character = 7,
||         line = 15
||       }
||     },
||     targetUri = "file:///home/tjdevries/tmp/dap-tester/src/main.rs"
||   }
|| }
--]]

local get_cargo_args = function(args)
  local result = {}

  assert(args.cargoArgs, vim.inspect(args))
  for idx, a in ipairs(args.cargoArgs) do
    table.insert(result, a)
    if idx == 1 and a == "test" then
      -- Don't run tests, just build
      table.insert(result, "--no-run")
    end
  end

  table.insert(result, "--message-format=json")

  -- TODO: handle cargoExtraArgs

  return result
end

M.select_rust_related = function(bufnr, win)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  win = win or vim.api.nvim_get_current_win()

  vim.lsp.buf_request(bufnr, "rust-analyzer/relatedTests", vim.lsp.util.make_position_params(win), function(err, result)
    local runnables = {}
    for _, v in ipairs(result) do
      table.insert(runnables, v.runnable)
    end

    vim.ui.select(runnables, {
      prompt = "Related Rust Runnables",
      format_item = function(item)
        return item.label
      end,
    }, function(item)
      M.debug_rust_runnable(item)
    end)
  end)
end

M.select_rust_runnable = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "experimental/runnables",
    { textDocument = vim.lsp.util.make_text_document_params(bufnr) },
    function(_, result)
      vim.ui.select(result, {
        prompt = "Rust Runnables",
        format_item = function(item)
          return item.label
        end,
      }, function(item)
        M.debug_rust_runnable(item)
      end)
    end
  )
end

M.debug_rust_runnable = function(item)
  item = item or {}
  item = vim.deepcopy(item)

  vim.notify("Debugging: " .. item.label)

  Job
    :new({
      command = "cargo",
      args = get_cargo_args(item.args),
      cwd = item.args.workspaceRoot,
      on_exit = function(j, code)
        if code and code > 0 then
          vim.notify "An error occured while compiling. Please fix all compilation issues and try again."
        end

        vim.schedule(function()
          for _, value in pairs(j:result()) do
            local json = vim.fn.json_decode(value)
            if type(json) == "table" and json.executable ~= vim.NIL and json.executable ~= nil then
              dap.run {
                name = "Rust tools debug",
                type = "rt_lldb",
                request = "launch",
                program = json.executable,
                args = item.args.executableArgs,
                cwd = item.workspaceRoot,
                stopOnEntry = false,
                runInTerminal = false,
              }
              break
            end
          end
        end)
      end,
    })
    :start()
end

return M
