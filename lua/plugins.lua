local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Only required if you have packer in your `opt` pack
cmd([[packadd packer.nvim]])

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install your plugins here
return packer.startup({
	function(use)
		-- Used by basically everything
		use("wbthomason/packer.nvim") -- Have packer manage itself
		use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
		use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

		-- General UI
		require("config.tokyonight").init(use) -- Color theme
		require("config.bufferline").init(use) -- Buffer/tab management
		require("config.lualine").init(use) -- Status bar with LSP support

		-- LSP & Completion
		require("config.cmp").init(use) -- Completion engine
		require("config.luasnip").init(use) -- Snippets engine
		require("lsp").init(use) -- LSP support

		-- Core
		require("config.startify").init(use) -- Start up page
		require("config.treesitter").init(use) -- Beautiful highlights & other file parsing goodies
		require("config.telescope").init(use) -- Fuzzy find engine
		require("config.nvim-tree").init(use) -- Nice file explorer
		require("config.whichkey").init(use) -- Keymaps manager
		require("config.autopairs").init(use) -- Auto close brackets etc
		require("config.comment").init(use) -- Great comment support
		require("config.toggleterm").init(use) -- Terminal manager

		-- Goodies
		require("config.indent-blankline").init(use) -- Add virtual text to indents
		require("config.gitsigns").init(use) -- Git changes displayed in side bar
		require("config.impatient").init(use) -- Speed up startup times
		require("config.wordmotion").init(use) -- Motion within words eg camelCase
		require("config.harpoon").init(use) -- Better short term recent file navigation

		-- Misc
		use("wsdjeg/vim-fetch") -- open file at line & col eg nvim a.txt:12:3
		use("editorconfig/editorconfig-vim") -- use .editorconfig settings when file present
		use("romainl/vim-cool") -- kill highlight when moving off searched word
		use("machakann/vim-highlightedyank") -- highlight yank for short time after yanking
		use({ "mbbill/undotree", cmd = "UndotreeToggle" })
		use("AndrewRadev/splitjoin.vim") -- allows to split one liner to multi lines
		use({ -- Change surrounding arks
			"machakann/vim-sandwich",
			config = function()
				vim.cmd([[runtime macros/sandwich/keymap/surround.vim]])
			end,
		})
		use({ -- Better jumps with s/S
			"ggandor/lightspeed.nvim",
			config = function()
				vim.cmd([[nnoremap f f]])
				vim.cmd([[nnoremap t t]])
			end,
		})
		use({ -- Solo view functions
			"folke/twilight.nvim",
			config = function()
				require("twilight").setup({})
			end,
			cmd = { "TwilightEnable", "Twilight" },
		})
		use({ -- TODO comment highlights & list view
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
		})

		-- Language specific
		use({ "kalvinpearce/ShaderHighLight", ft = { "shader", "hlsl", "glsl", "cginc" } })
		use({ "iamcco/markdown-preview.nvim", run = "cd app && npm i", ft = "md" }) -- open markdown file in web browser with live updates

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
