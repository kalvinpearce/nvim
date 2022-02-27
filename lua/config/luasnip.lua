local function config()
	local status_ok, luasnip = pcall(require, "luasnip")
	if not status_ok then
		return
	end

	local types = require("luasnip.util.types")
	luasnip.config.setup({
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "●", "GruvboxOrange" } },
				},
			},
			[types.insertNode] = {
				active = {
					virt_text = { { "●", "GruvboxBlue" } },
				},
			},
		},
	})
end

local function init(use)
	return use({
		"L3MON4D3/LuaSnip",
		requires = { "rafamadriz/friendly-snippets" },
		config = function()
			require("config.luasnip").config()
		end,
	})
end

return { init = init, config = config }
