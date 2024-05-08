-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = " ",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = " ",
  Misc = " ",
}

return {
  {
    "L3MON4D3/LuaSnip",
    build = "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip").filetype_extend("typescriptreact", { "html" })
          require("luasnip").filetype_extend("javascript", { "javascriptreact" })
          require("luasnip").filetype_extend("javascript", { "html" })
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
        paths = { vim.fn.stdpath("config") .. "/lua/custom-snippets/vscode" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      return {
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = "crates" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            -- Kind icons
            item.kind = string.format("%s %s", kind_icons[item.kind], item.kind) -- This concatonates the icons with the name of the item kin
            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              crates = "[Crate]"
            })[entry.source.name]
            return item
          end,
        },
        experimental = {
          ghost_text = { hl_group = "CmpGhostText" },
        },
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },
}
