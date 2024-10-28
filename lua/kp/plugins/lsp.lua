return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- LSP notifications
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      -- Helper for nvim plugin development
      { "folke/neodev.nvim", opts = {} },
      "b0o/SchemaStore.nvim",
      "folke/neoconf.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      capabilities = {},
      autoformat = true,
      format_notify = false,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        -- maxscript = {
        --   mason = false,
        -- },
        sourcekit = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      require("neoconf").setup {}

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local capabilities =
        vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), opts.capabilities or {})
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local servers = opts.servers
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } }
      end

      local augroup = require("kp.utils").augroup

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup "lsp_attach",
        callback = function()
          local set = require("kp.utils").map

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
          set("n", "<leader>ll", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
          set("n", "gd", function()
            require("telescope.builtin").lsp_definitions { reuse_win = true }
          end, { desc = "Goto Definition" })
          set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
          set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
          set("n", "gI", function()
            require("telescope.builtin").lsp_implementations { reuse_win = true }
          end, { desc = "Goto Implementation" })
          set("n", "gy", function()
            require("telescope.builtin").lsp_type_definitions { reuse_win = true }
          end, { desc = "Goto T[y]pe Definition" })
          set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
          set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
          set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
          set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
          set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
          set("n", "<leader>lf", require("kp.utils").format, { desc = "Format Document" })
          set("v", "<leader>lf", require("kp.utils").format, { desc = "Format Range" })
          set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
          set("n", "<leader>lA", function()
            vim.lsp.buf.code_action { context = { only = { "source" }, diagnostics = {} } }
          end, { desc = "Source Action" })
          set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
        end,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              if not err then
                vim.notify("trouble error", vim.log.levels.ERROR)
              else
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
}
