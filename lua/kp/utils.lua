local M = {}

--- Adds a new mapping with `noremap` and `silent` defaulted to `true`.
--- @param mode string|table    Mode short-name, see |nvim_set_keymap()|.
---                            Can also be list of modes to create mapping on multiple modes.
--- @param lhs string           Left-hand side |{lhs}| of the mapping.
--- @param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
--- @param opts table|nil Table of |:map-arguments|.
---                      - Same as |nvim_set_keymap()| {opts}, except:
---                        - "replace_keycodes" defaults to `true` if "expr" is `true`.
---                        - "noremap": inverse of "remap" (see below).
---                      - Also accepts:
---                        - "buffer" number|boolean Creates buffer-local mapping, `0` or `true`
---                        for current buffer.
---                        - remap: (boolean) Make the mapping recursive. Inverses "noremap".
---                        Defaults to `false`.
function M.map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    noremap = true,
    silent = true,
  })
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.format()
  vim.lsp.buf.format { async = true }
end

--- @param name string
--- @return number
function M.augroup(name)
  return vim.api.nvim_create_augroup("kp_" .. name, { clear = true })
end

---@alias NotifyOpts {lang?:string, title?:string, level?:number, once?:boolean, stacktrace?:boolean, stacklevel?:number}

---@param msg string|string[]
---@param opts? NotifyOpts
function M.notify(msg, opts)
  if vim.in_fast_event() then
    return vim.schedule(function()
      M.notify(msg, opts)
    end)
  end

  opts = opts or {}
  if type(msg) == "table" then
    msg = table.concat(
      vim.tbl_filter(function(line)
        return line or false
      end, msg),
      "\n"
    )
  end
  if opts.stacktrace then
    msg = msg .. M.pretty_trace { level = opts.stacklevel or 2 }
  end
  local lang = opts.lang or "markdown"
  local n = opts.once and vim.notify_once or vim.notify
  n(msg, opts.level or vim.log.levels.INFO, {
    on_open = function(win)
      local ok = pcall(function()
        vim.treesitter.language.add "markdown"
      end)
      if not ok then
        pcall(require, "nvim-treesitter")
      end
      vim.wo[win].conceallevel = 3
      vim.wo[win].concealcursor = ""
      vim.wo[win].spell = false
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].filetype = lang
        vim.bo[buf].syntax = lang
      end
    end,
    title = opts.title or "nvim",
  })
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.error(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.info(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.INFO
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.warn(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.WARN
  M.notify(msg, opts)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return M.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      M.info("Enabled " .. option, { title = "Option" })
    else
      M.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

local diagnostics_enabled = true
function M.toggle_diagnostics()
  diagnostics_enabled = not diagnostics_enabled
  if diagnostics_enabled then
    vim.diagnostic.enable(true)
    M.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.enable(false)
    M.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

function M.toggle_spell()
  M.toggle "spell"
end

function M.toggle_wrap()
  M.toggle "wrap"
end

function M.toggle_line_numbers()
  M.toggle("relativenumber", true)
  M.toggle "number"
end

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
function M.toggle_conceal()
  M.toggle("conceallevel", false, { 0, conceallevel })
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require "lazy.core.config"
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    vim.schedule(function()
      fn(name)
    end)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

return M
