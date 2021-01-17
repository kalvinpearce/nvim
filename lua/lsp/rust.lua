local lspconfig = require('lspconfig')
local on_attach = require("lsp.attach").on_attach

lspconfig.rust_analyzer.setup {
  on_attach = on_attach
}
