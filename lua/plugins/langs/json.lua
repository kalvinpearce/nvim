return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "b0o/SchemaStore.nvim",
  --   },
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       jsonls = {
  --         settings = {
  --           json = {
  --             format = {
  --               enable = true,
  --             },
  --             schemas = require("schemastore").json.schemas(),
  --             validate = { enable = true },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
