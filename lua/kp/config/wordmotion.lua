local function config()
	vim.g.wordmotion_mappings = {
		["w"] = "<s-w>",
		["b"] = "<s-b>",
		["e"] = "<s-e>",
		["ge"] = "g<s-e>",
		["aw"] = "a<s-w>",
		["iw"] = "i<s-w>",
		["<C-R><C-W>"] = "<C-R><s-w>",
	}
end

local function init(use)
	return use({
		"chaoren/vim-wordmotion",
		config = function()
			require("kp.config.wordmotion").config()
		end,
	})
end

return { init = init, config = config }
