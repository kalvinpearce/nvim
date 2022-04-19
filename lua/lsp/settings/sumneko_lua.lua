return {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "jit" },
			},
			format = {
				enable = false,
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				-- library = {
				-- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				-- 	[vim.fn.stdpath("config") .. "/lua"] = true,
				-- },
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
