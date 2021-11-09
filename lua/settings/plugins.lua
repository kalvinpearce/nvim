local execute = vim.api.nvim_command
local fn, cmd = vim.fn, vim.cmd

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- Only required if you have packer in your `opt` pack
cmd [[packadd packer.nvim]]

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

return require("packer").startup(
  {
    function(use)
      -- Packer can manage itself as an optional plugin
      use {"wbthomason/packer.nvim", opt = true}

      use "nvim-lua/plenary.nvim"
      use "nvim-lua/popup.nvim"

      -- Misc IDE Stuff
      use "mhinz/vim-startify" -- start screen
      use "nvim-treesitter/nvim-treesitter"
      use {"neoclide/coc.nvim", branch = "release"}
      use "voldikss/vim-floaterm"
      use "wsdjeg/vim-fetch" -- open file at line & col eg nvim a.txt:12:3
      use "editorconfig/editorconfig-vim"
      use { 'rmagatti/auto-session',
        config = function() require('auto-session').setup { } end
      }
      use "nvim-telescope/telescope.nvim"
      use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
      use "fannheyward/telescope-coc.nvim"
      use { 'kyazdani42/nvim-tree.lua',
          requires = 'kyazdani42/nvim-web-devicons'
      }
      use { "ahmedkhalf/project.nvim",
        config = function() require("project_nvim").setup { } end
      }
      use { "steelsojka/pears.nvim",
        config = function () require('pears').setup() end
      }

      -- Auto Tweeks
      use "rrethy/vim-illuminate" -- highlight matching words when cursor on it
      use "romainl/vim-cool" -- kill highlight when moving off searched word
      use "machakann/vim-highlightedyank"

      -- Manual Tweeks
      use { 'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
      }
      use "ThePrimeagen/harpoon"
      use "chaoren/vim-wordmotion"
      use "AndrewRadev/splitjoin.vim" -- allows to split one liner to multi lines
      use "machakann/vim-sandwich" -- Change surrounding arks
      use "unblevable/quick-scope"
      use {"mbbill/undotree", cmd="UndotreeToggle"}

      -- Git
      use "tpope/vim-fugitive"
      use "rhysd/conflict-marker.vim" -- Highlight conflict markers.[x and ]x, ct for themselves, co for ourselves, cn for none and cb
      use { 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
      }

      -- UI
      use {"kyazdani42/nvim-web-devicons",
        config = function () require"nvim-web-devicons".setup() end
      }
      use "rakr/vim-one"
      use "romgrk/barbar.nvim"
      use { 'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
      }
      use "norcalli/nvim-colorizer.lua"

      -- Misc
      use "tweekmonster/startuptime.vim" -- benchmark startup
      use { "folke/todo-comments.nvim",
          requires = "nvim-lua/plenary.nvim",
          config = function() require("todo-comments").setup { } end
      }

      -- Language specific
      use { "mhinz/vim-crates", ft="toml"}
      use { "kalvinpearce/ShaderHighLight", ft={"shader", "hlsl", "glsl", "cginc"}}
      use {"iamcco/markdown-preview.nvim", ft="md"}

    end,
    config = {
      display = {
        open_fn = require "packer.util".float
      }
    }
  }
)
