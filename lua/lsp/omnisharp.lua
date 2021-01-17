local pid = vim.fn.getpid()
local omnisharp_bin = "C:\\Users\\Kev\\AppData\\Local\\omnisharp\\OmniSharp.exe"
local lspconfig = require('lspconfig')
local on_attach = require("lsp.attach").on_attach

lspconfig.omnisharp.setup {
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = on_attach
}
