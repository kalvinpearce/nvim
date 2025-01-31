return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
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
    },
    ---@class PluginLspOpts
    opts = {
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
        sourcekit = {
          root_dir = function(filename, _)
            local util = require "lspconfig.util"
            -- If find *.uproject return nil
            if util.root_pattern "*.uproject"(filename) then
              return nil
            end

            return util.root_pattern "buildServer.json"(filename)
              or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
              -- better to keep it at the end, because some modularized apps contain multiple Package.swift files
              or util.root_pattern("compile_commands.json", "Package.swift")(filename)
              or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
          end,
        },
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
      local capabilities =
        vim.tbl_deep_extend("force", {}, require("blink.cmp").get_lsp_capabilities {}, opts.capabilities or {})
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
          -- set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Goto Definition" })
          -- set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "References" })
          set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
          -- set("n", "gI", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Goto Implementation" })
          -- set("n", "gy", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Goto T[y]pe Definition" })
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
    enabled = false,
    cmd = "Trouble",
    opts = { use_diagnostic_signs = true },
    config = function(opts)
      local config = require "fzf-lua.config"
      local actions = require("trouble.sources.fzf").actions
      config.defaults.actions.files["ctrl-t"] = actions.open

      require("trouble").setup(opts)
    end,
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "]t",
        function()
          require("trouble").next { skip_groups = true, jump = true }
        end,
        desc = "Next Trouble",
      },
      {
        "[y",
        function()
          require("trouble").prev { skip_groups = true, jump = true }
        end,
        desc = "Previous Trouble",
      },
    },
  },
}
