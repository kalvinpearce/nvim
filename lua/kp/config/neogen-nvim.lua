local function config()
	local status_ok, neogen = pcall(require, "neogen")
	if not status_ok then
		return
	end

	neogen.setup({ snippet_engine = "luasnip" })
end

local function init(use)
	return use({
		"danymat/neogen",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("kp.config.neogen-nvim").config()
		end,
	})
end

return { init = init, config = config }
