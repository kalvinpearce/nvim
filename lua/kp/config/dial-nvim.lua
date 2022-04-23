local function config()
	local status_ok, dial = pcall(require, "dial")
	if not status_ok then
		return
	end

	local map = require("keymaps").map
	map("n", "<C-a>", "<Plug>(dial-increment)", { noremap = false })
	map("n", "<C-x>", "<Plug>(dial-decrement)", { noremap = false })
	map("v", "<C-a>", "<Plug>(dial-increment)", { noremap = false })
	map("v", "<C-x>", "<Plug>(dial-decrement)", { noremap = false })
	map("v", "g<C-a>", "<Plug>(dial-increment-additional)", { noremap = false })
	map("v", "g<C-x>", "<Plug>(dial-decrement-additional)", { noremap = false })

  dial.augends["custom#boolean"] = dial.common.enum_cyclic{
    name = "boolean",
    strlist = {"true", "false"},
  }
  dial.config.searchlist.normal = {
    "number#decimal",
    "number#hex",
    "number#binary",
    "date#[%Y/%m/%d]",
    "markup#markdown#header",
    "custom#boolean",
  }
end

local function init(use)
	return use({
		"monaqa/dial.nvim",
		config = function()
			require("kp.config.dial-nvim").config()
		end,
	})
end

return { init = init, config = config }
