return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/schemastore.nvim" },
    },
    opts = function(_, opts)
      return {
        servers = vim.tbl_deep_extend("force", opts.servers or {}, {
          jsonls = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
                format = { enable = true },
              },
            },
          },
        }),
      }
    end,
  },
  -- TODO: Lazy load schemaStore with the following when on_new_config is supported
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     { "b0o/schemastore.nvim" },
  --   },
  --   opts = {
  --     servers = {
  --       jsonls = {
  --         -- lazy-load schemastore when needed
  --         on_new_config = function(new_config)
  --           new_config.settings.json.schemas = new_config.settings.json.schemas or {}
  --           vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  --         end,
  --         settings = {
  --           json = {
  --             format = {
  --               enable = true,
  --             },
  --             validate = { enable = true },
  --             schemas = require("schemastore").json.schemas(),
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
