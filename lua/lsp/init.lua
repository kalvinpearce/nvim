local function config()
	local status_ok, _ = pcall(require, "lspconfig")
	if not status_ok then
		return
	end

	require("lsp.lsp-installer")
	require("lsp.handlers").setup()
	require("lsp.null-ls")
end

local function init(use)
	return use({
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("lsp").config()
		end,
	})
end

return { init = init, config = config }
