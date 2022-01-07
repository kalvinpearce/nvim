local function config()
	local status_ok, telescope = pcall(require, "telescope")
	if not status_ok then
		return
	end

	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "smart" },

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-h>"] = actions.which_key,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
			},
		},
	})

	telescope.load_extension("fzf")

	local map = require("keymaps").map
	map("n", "<C-p>", "<cmd>Telescope find_files<cr>")
end

local function init(use)
	return use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } },
		config = function()
			require("config.telescope").config()
		end,
	})
end

return { init = init, config = config }
