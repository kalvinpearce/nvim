return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        jsonls = {
          settings = {
            json = {
              format = {
                enable = true,
              },
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
