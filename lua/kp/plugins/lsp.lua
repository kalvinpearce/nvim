return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
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
        wgsl_analyzer = {
          mason = false,
        },
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

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          local map = vim.keymap.set

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
          map("n", "<leader>ll", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
          map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
          map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
          map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
          map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
          map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Document" })
          map("v", "<leader>lf", vim.lsp.buf.format, { desc = "Format Range" })
          map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
          map("n", "<leader>lA", function()
            vim.lsp.buf.code_action { context = { only = { "source" }, diagnostics = {} } }
          end, { desc = "Source Action" })
          map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
        end,
      })

      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
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
}
