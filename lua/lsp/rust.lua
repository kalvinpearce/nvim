local lspconfig = require('lspconfig')
local on_attach = require("lsp.attach").attach

lspconfig.rust_analyzer.setup {
  on_attach = on_attach
}
