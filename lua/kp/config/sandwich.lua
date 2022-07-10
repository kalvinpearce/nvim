local function config()
	vim.cmd([[runtime macros/sandwich/keymap/surround.vim]])
end

local function init(use)
	return use({
		"machakann/vim-sandwich",
		config = function()
			require("kp.config.sandwich").config()
		end,
	})
end

return { init = init, config = config }
