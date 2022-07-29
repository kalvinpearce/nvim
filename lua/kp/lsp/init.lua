local function config()
	local status_ok, _ = pcall(require, "lspconfig")
	if not status_ok then
		return
	end

	require("kp.lsp.mason")
	require("kp.lsp.handlers").setup()
	require("kp.lsp.null-ls")
	require("lsp_signature").setup({})
end

local function init(use)
	return use({
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"ray-x/lsp_signature.nvim",
		},
		config = function()
			require("kp.lsp").config()
		end,
	})
end

return { init = init, config = config }
