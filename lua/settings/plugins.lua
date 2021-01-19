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

      -- Coc
      use "nvim-lua/plenary.nvim"
      use "nvim-treesitter/nvim-treesitter"
      use "neovim/nvim-lspconfig"
      use {"neoclide/coc.nvim", branch = "release"}
      use "antoinemadec/coc-fzf" -- coc and fzf together

      -- Telescope
      use "nvim-lua/popup.nvim"
      use "nvim-telescope/telescope.nvim"

      -- Misc IDE Stuff
      use "mhinz/vim-startify" -- start screen
      use "voldikss/vim-floaterm"
      use "mbbill/undotree" -- undo tree
      use {"junegunn/fzf", run = "./install --all"} -- Fuzzy Searcher
      use "junegunn/fzf.vim"
      use "gfanto/fzf-lsp.nvim"

      -- Auto Tweeks
      use "oberblastmeister/rooter.nvim" -- root dir switcher
      use "cohama/lexima.vim" -- Auto close parentheses and repeat by dot dot dot...
      use "rrethy/vim-illuminate" -- highlight matching words when cursor on it
      use "romainl/vim-cool"

      -- Manual Tweeks
      use "tpope/vim-commentary" -- comments like gcc
      use "mhartington/formatter.nvim"
      use "AndrewRadev/splitjoin.vim" -- allows to split one liner to multi lines
      use "machakann/vim-sandwich" -- Change surrounding arks

      -- Git
      use "tpope/vim-fugitive"
      use "tpope/vim-rhubarb"
      use "rhysd/conflict-marker.vim" -- Highlight conflict markers.[x and ]x, ct for themselves, co for ourselves, cn for none and cb
      use "lewis6991/gitsigns.nvim"
      use "f-person/git-blame.nvim"

      -- Movement
      use "skamsie/vim-lineletters"
      use "unblevable/quick-scope"

      --Test
      use "janko/vim-test"

      -- Themes
      use "kyazdani42/nvim-web-devicons"
      use "rakr/vim-one"
      use "sheerun/vim-polyglot"

      -- UI
      use "romgrk/barbar.nvim"
      use "glepnir/galaxyline.nvim"
      use "machakann/vim-highlightedyank"
      use {"rrethy/vim-hexokinase", run = "make hexokinase"}

      -- Misk
      use "tweekmonster/startuptime.vim" -- benchmark startup
      use "editorconfig/editorconfig-vim"
      use "cespare/vim-toml"

    end,
    config = {
      display = {
        open_fn = require "packer.util".float
      }
    }
  }
)
