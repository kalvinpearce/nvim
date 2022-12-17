local function config()
	local status_ok, lsp = pcall(require, "lsp-zero")
	if not status_ok then
		return
	end

	lsp.preset("recommended")
	lsp.ensure_installed({
		"sumneko_lua",
		"rust_analyzer",
		"tsserver",
		"eslint",
	})

	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	local kind_icons = {
		Text = "",
		Method = "m",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	lsp.setup_nvim_cmp({
		mapping = lsp.defaults.cmp_mappings({
			["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					luasnip = "[Snippet]",
					buffer = "[Buffer]",
					path = "[Path]",
				})[entry.source.name]
				return vim_item
			end,
		},
	})

	vim.diagnostic.config({
		virtual_text = true,
	})

	lsp.on_attach(function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		-- Set autocommands conditional on server_capabilities
		if client.server_capabilities.document_highlight then
			vim.api.nvim_exec(
				[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
				false
			)
		end

		local format = function()
			vim.lsp.buf.format({ async = true })
		end

		local map = vim.keymap.set
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
		map("n", "<leader>rn", vim.lsp.buf.rename, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "<leader>a", vim.lsp.buf.code_action, opts)
		map("n", "<leader>lf", format, opts)
		map("n", "[d", vim.diagnostic.goto_prev, opts)
		map("n", "]d", vim.diagnostic.goto_next, opts)
		map("n", "gl", vim.diagnostic.open_float, opts)
		map("n", "<leader>q", vim.diagnostic.setloclist, opts)
		map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		map("n", "<leader>wl", function()
			vim.inspect(vim.lsp.buf.list_workspace_folders())
		end, opts)
		vim.api.nvim_create_user_command("Format", format, {})
	end)

	local sumneko_opts = require("kp.config.lsp-settings.sumneko_lua")
	lsp.configure("sumneko_lua", sumneko_opts)
	local json_opts = require("kp.config.lsp-settings.jsonls")
	lsp.configure("jsonls", json_opts)
	-- Setup nvim completions
	lsp.nvim_workspace({ library = vim.api.nvim_get_runtime_file("", true) })

	lsp.setup()

	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions

	null_ls.setup({
		debug = false,
		sources = {
			formatting.prettier,
			formatting.stylua,
			diagnostics.eslint,
			code_actions.eslint,
			formatting.rustywind,
		},
		on_attach = function(client)
			if client.server_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end

local function init(use)
	return use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("kp.config.lsp").config()
		end,
	})
end

return { init = init, config = config }
