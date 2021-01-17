local lspconfig = require('lspconfig')
local on_attach = require("lsp.attach").on_attach

lspconfig.vimls.setup {
  on_attach = on_attach
}
