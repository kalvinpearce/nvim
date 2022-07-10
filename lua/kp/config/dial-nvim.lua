local function config()
	local status_ok, dialConfig = pcall(require, "dial.config")
	if not status_ok then
		return
	end

	local augend = require("dial.augend")
	dialConfig.augends:register_group({
		default = {
			augend.constant.alias.bool,
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.date.alias["%Y/%m/%d"],
		},
	})

	local map = require("kp.utils").map
	local dialMap = require("dial.map")
	map("n", "<C-a>", dialMap.inc_normal(), { noremap = true })
	map("n", "<C-x>", dialMap.dec_normal(), { noremap = true })
	map("v", "<C-a>", dialMap.inc_visual(), { noremap = true })
	map("v", "<C-x>", dialMap.dec_visual(), { noremap = true })
	map("v", "g<C-a>", dialMap.inc_gvisual(), { noremap = true })
	map("v", "g<C-x>", dialMap.dec_gvisual(), { noremap = true })
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
