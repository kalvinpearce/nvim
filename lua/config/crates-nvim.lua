local function config()
  local status_ok, crates = pcall(require, "crates")
  if not status_ok then
    return
  end

	crates.setup()

	vim.cmd([[
    augroup _load_crates
      autocmd!
      autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }
    augroup end
  ]])
end

local function init(use)
	return use({
		"saecki/crates.nvim",
		tag = "v0.1.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.crates-nvim").config()
		end,
	})
end

return { init = init, config = config }
