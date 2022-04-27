local function config()
	local status_ok, neoTree = pcall(require, "neo-tree")
	if not status_ok then
		return
	end

	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

	-- See ":help neo-tree-highlights" for a list of available highlight groups
	vim.cmd([[
    hi link NeoTreeDirectoryName Directory
    hi link NeoTreeDirectoryIcon NeoTreeDirectoryName
  ]])

	neoTree.setup({
		close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "ﰊ",
				default = "*",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
			},
			git_status = {
				highlight = "NeoTreeDimText", -- if you remove this the status will be colorful
			},
		},
		filesystem = {
			filtered_items = { --These filters are applied to both browsing and searching
				hide_dotfiles = false,
				hide_gitignored = true,
			},
			follow_current_file = false, -- This will find and focus the file in the active buffer every
			-- time the current file is changed while the tree is open.
			use_libuv_file_watcher = false, -- This will use the OS level file watchers
			-- to detect changes instead of relying on nvim autocmd events.
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_split",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			window = {
				position = "left",
				width = 40,
				mappings = {
					["<space>"] = "none",
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["l"] = "open",
					["h"] = "close_node",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["C"] = "close_node",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["I"] = "toggle_gitignore",
					["R"] = "refresh",
					["/"] = "fuzzy_finder",
					--["/"] = "filter_as_you_type", -- this was the default until v1.28
					--["/"] = "none" -- Assigning a key to "none" will remove the default mapping
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["m"] = "move", -- takes text input for destination
					["q"] = "close_window",
				},
			},
		},
		buffers = {
			show_unloaded = true,
			window = {
				position = "left",
				mappings = {
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["l"] = "open",
					["h"] = "close_node",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["R"] = "refresh",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["bd"] = "buffer_delete",
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["l"] = "open",
					["h"] = "close_node",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["C"] = "close_node",
					["R"] = "refresh",
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				},
			},
		},
	})
end

local function init(use)
	return use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("kp.config.neo-tree-nvim").config()
		end,
	})
end

return { init = init, config = config }