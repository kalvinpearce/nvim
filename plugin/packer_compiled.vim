" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "C:\\Users\\Kev\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\Kev\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\Kev\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\Kev\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\Kev\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ShaderHighLight = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ShaderHighLight"
  },
  ["coc-fzf"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\coc-fzf"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\coc.nvim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\conflict-marker.vim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\editorconfig-vim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\formatter.nvim"
  },
  fzf = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fzf.vim"
  },
  ["git-blame.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\git-blame.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\markdown-preview.nvim"
  },
  ["neoline.vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neoline.vim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons"
  },
  ["omnisharp-vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\omnisharp-vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\quick-scope"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\splitjoin.vim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\startuptime.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\undotree"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-commentary"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-cool"
  },
  ["vim-crates"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-crates"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fetch"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive"
  },
  ["vim-highlightedyank"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-highlightedyank"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-illuminate"
  },
  ["vim-lineletters"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-lineletters"
  },
  ["vim-one"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-one"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-polyglot"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rhubarb"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rooter"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-sandwich"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-signify"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-startify"
  },
  ["vim-test"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-test"
  },
  ["vim-todo"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-todo"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-toml"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "C:\\Users\\Kev\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-wordmotion"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
