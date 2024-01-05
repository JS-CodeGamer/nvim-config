return {
  "L3MON4D3/LuaSnip",
  build = "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "nvim-cmp",
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  lazy = true,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = {
        vim.fn.stdpath("config") .. "/lua/custom-snippets/vscode",
      },
    })
  end,
}
