local function config()
	local status_ok, configs = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end

	configs.setup({
		ensure_installed = "maintained",
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true, disable = { "yaml" } },
		autopairs = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
	})
end

local function init(use)
	return use({
		"nvim-treesitter/nvim-treesitter",
		requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
		-- run = ":TSUpdate",
		config = function()
			require("config.treesitter").config()
		end,
	})
end

return { init = init, config = config }
