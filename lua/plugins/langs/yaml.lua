return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/schemastore.nvim" },
    },
    opts = function(_, opts)
      return {
        servers = vim.tbl_deep_extend("force", opts.servers or {}, {
          yamlls = {
            capabilities = {
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            },
            settings = {
              redhat = { telemetry = { enabled = false } },
              yaml = {
                keyOrdering = false,
                format = { enable = true },
                validate = true,
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
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
  --       yamlls = {
  --         capabilities = {
  --           textDocument = {
  --             foldingRange = {
  --               dynamicRegistration = false,
  --               lineFoldingOnly = true,
  --             },
  --           },
  --         },
  --         -- lazy-load schemastore when needed
  --         on_new_config = function(new_config)
  --           new_config.settings.yaml.schemas = vim.tbl_deep_extend(
  --             "force",
  --             new_config.settings.yaml.schemas or {},
  --             require("schemastore").yaml.schemas()
  --           )
  --         end,
  --         settings = {
  --           redhat = { telemetry = { enabled = false } },
  --           yaml = {
  --             keyOrdering = false,
  --             format = { enable = true },
  --             validate = true,
  --             schemaStore = {
  --               enable = false,
  --               url = "",
  --             },
  --             schemas = require("schemastore").yaml.schemas(),
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
