local servers = {
  -- can specify version like name@xxx.yyy
  "lua_ls",
  "pyright",
  "jsonls",
  "tsserver",
  "clangd",
  "bashls",
  "ast_grep",
  "rust_analyzer"
}

return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "RubixDev/mason-update-all",
      config = function()
        require("mason-update-all").setup()
      end,
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  -- automatic installation only
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = vim.tbl_extend("keep", servers, { "rust_analyzer" }),
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", opts = {} }, -- manage lsp conf from json
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for _, server in pairs(servers) do
        opts = {
          on_attach = require("js.plugins.lsp.handlers").on_attach,
          capabilities = require("js.plugins.lsp.handlers").capabilities,
        }
        local server_name = vim.split(server, "@")[1]
        -- use settings for dynamic options
        -- use neoconf for static options
        local require_ok, conf_opts = pcall(require, "js.plugins.lsp.settings." .. server_name)
        if require_ok then
          opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end
        lspconfig[server_name].setup(opts)
      end
      require("js.plugins.lsp.handlers").setup()
    end,
  },

  "folke/neodev.nvim",                                              -- for neovim/vim lsp functionality
  { "b0o/schemastore.nvim", lazy = true, ft = { "json", "yaml" } }, -- json schemastore
}
