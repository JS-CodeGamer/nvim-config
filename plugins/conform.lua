return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  event = "BufWritePre",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" } })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = {
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      sh = { "shfmt" },
      c = { "clangd" },
      cpp = { "clangd" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      --
      -- # Example of using shfmt with extra args
      -- shfmt = {
      --   prepend_args = { "-i", "2", "-ci" },
      -- },
    },
    format_on_save = function(bufnr)
      -- Disable autoformat on certain filetypes
      local ignore_filetypes = { "sql" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end
      -- ...additional logic...
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatOnSave"),
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
