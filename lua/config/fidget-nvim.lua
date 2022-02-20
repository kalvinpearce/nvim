local function config()
	require("fidget").setup({})
end

local function init(use)
	return use({
		"j-hui/fidget.nvim",
		config = function()
			require("config.fidget-nvim").config()
		end,
	})
end

return { init = init, config = config }
