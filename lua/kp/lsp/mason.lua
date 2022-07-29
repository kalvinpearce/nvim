local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local handlers = require("kp.lsp.handlers")
local opts = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

local masonLsp = require("mason-lspconfig")
mason.setup()
masonLsp.setup()
masonLsp.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup(opts)
	end,
	["jsonls"] = function()
		local jsonls_opts = require("kp.lsp.settings.jsonls")
		require("lspconfig")["jsonls"].setup(vim.tbl_deep_extend("force", jsonls_opts, opts))
	end,
	["sumneko_lua"] = function()
		local sumneko_opts = require("kp.lsp.settings.sumneko_lua")
		require("lspconfig")["sumneko_lua"].setup(vim.tbl_deep_extend("force", sumneko_opts, opts))
	end,
})
