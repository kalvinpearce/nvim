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
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerSync",
	group = packer_group,
	pattern = "plugins.lua",
})

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
		require("kp.config.bluloco").init(use) -- Color theme
		require("kp.config.bufferline").init(use) -- Buffer/tab management
		-- require("kp.config.tabline-nvim").init(use) -- Buffer/tab management
		require("kp.config.lualine").init(use) -- Status bar with LSP support

		-- Core
		require("kp.config.lsp").init(use) -- LSP support
		require("kp.config.treesitter").init(use) -- Beautiful highlights & other file parsing goodies
		require("kp.config.telescope").init(use) -- Fuzzy find engine
		require("kp.config.neo-tree-nvim").init(use) -- Nicer file explorer
		require("kp.config.whichkey").init(use) -- Keymaps manager
		require("kp.config.autopairs").init(use) -- Auto close brackets etc
		require("kp.config.comment").init(use) -- Great comment support
		require("kp.config.toggleterm").init(use) -- Terminal manager
		require("kp.config.nvim-scrollbar").init(use) -- Add nice scrollbar
		require("kp.config.project").init(use) -- Projects
		require("kp.config.session-manager").init(use) -- Auto session handling and management
		require("kp.config.alpha").init(use) -- Start up page

		-- Goodies
		require("kp.config.indent-blankline").init(use) -- Add virtual text to indents
		require("kp.config.gitsigns").init(use) -- Git changes displayed in side bar
		require("kp.config.impatient").init(use) -- Speed up startup times
		require("kp.config.wordmotion").init(use) -- Motion within words eg camelCase (VIM)
		require("kp.config.harpoon").init(use) -- Better short term recent file navigation
		require("kp.config.dial-nvim").init(use) -- Better c-a/c-x
		use("stevearc/dressing.nvim") -- Pretty stuff for vim.ui.select & vim.ui.input
		require("kp.config.nvim-notify").init(use) -- Pretty vim.notify
		require("kp.config.todo").init(use) -- TODO: comment highlights & list view
		require("kp.config.fidget-nvim").init(use) -- LSP loading info ticker
		require("kp.config.dim-unused").init(use) -- Dim unused code
		require("kp.config.guess-indent-nvim").init(use) -- Auto set indent based on file
		require("kp.config.neogen-nvim").init(use) -- Doc comments generator
		require("kp.config.cinnamon").init(use) -- Smooth movement for EVERYTHING
		require("kp.config.wilder").init(use) -- Better wildmenu
		require("kp.config.trouble").init(use) -- List lsp diagnostics

		-- Misc
		use("kalvinpearce/gitignore-gen.nvim")
		use("wsdjeg/vim-fetch") -- open file at line & col eg nvim a.txt:12:3 (VIM)
		use("editorconfig/editorconfig-vim") -- use .editorconfig settings when file present (VIM)
		use("romainl/vim-cool") -- kill highlight when moving off searched word (VIM)
		use({ "mbbill/undotree", cmd = "UndotreeToggle" }) -- (VIM)
		use("AndrewRadev/splitjoin.vim") -- allows to split one liner to multi lines (VIM)
		require("kp.config.surround").init(use) -- Change surrounding arks
		use({ "ggandor/lightspeed.nvim", requires = "tpope/vim-repeat" }) -- Better jumps with s/S
		use({ "jlanzarotta/bufexplorer" }) -- Better buffer jumps (VIM)
		require("kp.config.twilight").init(use) -- Solo view functions
		use({ "mg979/vim-visual-multi" }) -- (VIM)

		-- Language specific
		use({ "kalvinpearce/ShaderHighLight", ft = { "shader", "hlsl", "glsl", "cginc" } })
		require("kp.config.crates-nvim").init(use) -- Juiced rust crates support in cargo.toml
		require("kp.config.markdown-preview").init(use) -- open markdown file in web browser with live updates
		use("jxnblk/vim-mdx-js") -- MDX support (VIM)
		use({ "ellisonleao/glow.nvim", branch = "main" }) -- Nice markdown visualisation

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
