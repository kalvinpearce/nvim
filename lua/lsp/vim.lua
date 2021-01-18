local lspconfig = require('lspconfig')
local on_attach = require("lsp.attach").attach

lspconfig.vimls.setup {
  on_attach = on_attach
}
