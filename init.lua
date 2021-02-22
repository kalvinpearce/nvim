require("settings")
require("plugins")
require("coc")

vim.cmd "cd d:/Repos/"

function Source()
    require('plenary.reload').reload_module('settings')
    require('plenary.reload').reload_module('plugins')
    require('plenary.reload').reload_module('coc')
    require("settings")
    require("plugins")
    require("coc")
end
vim.cmd "command! SourceConfig lua Source()"
