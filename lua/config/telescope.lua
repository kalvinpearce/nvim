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
			-- file_ignore_patterns = {
			-- 	"^.git/",
			-- 	".git",
			-- 	"node_modules",
			-- },

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
		pickers = {
			buffers = {
				show_all_buffers = true,
				mappings = {
					i = {
						["<c-d>"] = "delete_buffer",
					},
				},
			},
			find_files = {
				hidden = true,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("lsp_handlers")

	local map = require("keymaps").map
	map("n", "<C-p>", "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--no-ignore', '-g', '!.git' }})<cr>")
end

local function init(use)
	return use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"gbrlsnchs/telescope-lsp-handlers.nvim",
		},
		config = function()
			require("config.telescope").config()
		end,
	})
end

return { init = init, config = config }
