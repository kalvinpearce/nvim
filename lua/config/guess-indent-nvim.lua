local function config()
	local status_ok, guessIndent = pcall(require, "guess-indent")
	if not status_ok then
		return
	end

  guessIndent.setup({})
end

local function init(use)
	return use({
		"nmac427/guess-indent.nvim",
		config = function()
			require("config.guess-indent-nvim").config()
		end,
	})
end

return { init = init, config = config }

