local Log = {}

Log.levels = {
  TRACE = 1,
  DEBUG = 2,
  INFO = 3,
  WARN = 4,
  ERROR = 5,
}
vim.tbl_add_reverse_lookup(Log.levels)

local notify_opts = {}

function Log:init()
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end

  package.loaded["packer.log"] = nil
  require("packer.log").new {}

  local log_level = Log.levels["WARN"]
  local vim_log = {
    vim = {
      sinks = {
        structlog.sinks.Console(log_level, {
          async = false,
          processors = {
            structlog.processors.Namer(),
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 2 }),
            structlog.processors.Timestamper "%H:%M:%S",
          },
          formatter = structlog.formatters.FormatColorizer( --
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" },
            { level = structlog.formatters.FormatColorizer.color_level() }
          ),
        }),
        structlog.sinks.File(log_level, self:get_path(), {
          processors = {
            structlog.processors.Namer(),
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 2 }),
            structlog.processors.Timestamper "%H:%M:%S",
          },
          formatter = structlog.formatters.Format( --
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" }
          ),
        }),
      },
    },
  }

  structlog.configure(vim_log)
  local logger = structlog.get_logger "vim"

  return logger
end

--- Configure the sink in charge of logging notifications
---@param notif_handle table The implementation used by the sink for displaying the notifications
function Log:configure_notifications(notif_handle)
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return
  end

  local default_namer = function(logger, entry)
    entry["title"] = logger.name
    return entry
  end

  local notify_opts_injecter = function(_, entry)
    for key, value in pairs(notify_opts) do
      entry[key] = value
    end
    notify_opts = {}
    return entry
  end

  local sink = structlog.sinks.NvimNotify(Log.levels.INFO, {
    processors = {
      default_namer,
      notify_opts_injecter,
    },
    formatter = structlog.formatters.Format( --
      "%s",
      { "msg" },
      { blacklist_all = true }
    ),
    -- This should probably not be hard-coded
    params_map = {
      icon = "icon",
      keep = "keep",
      on_open = "on_open",
      on_close = "on_close",
      timeout = "timeout",
      title = "title",
    },
    impl = notif_handle,
  })

  -- table.insert(self.__handle.sinks, sink)
end

--- Adds a log entry using Plenary.log
---@param msg any
---@param level string [same as vim.log.log_levels]
function Log:add_entry(level, msg, event)
  local logger = self:get_logger()
  if not logger then
    return
  end
  logger:log(level, vim.inspect(msg), event)
end

---Retrieves the handle of the logger object
---@return table|nil logger handle if found
function Log:get_logger()
  if self.__handle then
    return self.__handle
  end

  local logger = self:init()
  if not logger then
    return
  end

  self.__handle = logger
  return logger
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return string.format("%s/%s.log", get_cache_dir(), "vim")
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event)
  self:add_entry(self.levels.TRACE, msg, event)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event)
  self:add_entry(self.levels.DEBUG, msg, event)
end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event)
  self:add_entry(self.levels.INFO, msg, event)
end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event)
  self:add_entry(self.levels.WARN, msg, event)
end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event)
  self:add_entry(self.levels.ERROR, msg, event)
end

setmetatable({}, Log)

return Log
