local function config()
	local map = require("kp.utils").map
	map("n", "<a-n>", ":lua require('harpoon.mark').add_file()<cr>")
	map("n", "<a-h>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
	map("n", "<a-u>", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")
	map("n", "<a-j>", ":lua require('harpoon.ui').nav_file(1)<cr>")
	map("n", "<a-k>", ":lua require('harpoon.ui').nav_file(2)<cr>")
	map("n", "<a-l>", ":lua require('harpoon.ui').nav_file(3)<cr>")
	map("n", "<a-;>", ":lua require('harpoon.ui').nav_file(4)<cr>")
end

local function init(use)
	return use({
		"ThePrimeagen/harpoon",
		config = function()
			require("kp.config.harpoon").config()
		end,
	})
end

return { init = init, config = config }
