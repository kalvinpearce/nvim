local function config() end

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
