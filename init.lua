--[[
-- Setup initial configuration,
--
-- Primarily just download and execute lazy.nvim
--]]
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Set up lazy, and load `lua/kp/plugins/` folder
require("lazy").setup({
  spec = {
    { import = "kp.plugins" },
    { import = "kp.languages" },
  },
}, {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  change_detection = {
    notify = false,
  },
  checker = { enabled = false },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
