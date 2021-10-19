function Source(reload)
    if(reload) then
        require('plenary.reload').reload_module('settings')
        require('plenary.reload').reload_module('plugins')
        require('plenary.reload').reload_module('coc')
    end
    require("settings")
    require("plugins")
    require("coc")
end
Source(false)
vim.cmd "command! SourceConfig lua Source(true)"
