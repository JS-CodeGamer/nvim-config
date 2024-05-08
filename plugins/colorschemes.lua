local colorschemes = {
  kanagawa = {
    "rebelot/kanagawa.nvim",
    opts = {
      background = { dark = "dragon" },
      transparent = JSConfig.transparent
    }
  },
  oxocarbon = { "nyoom-engineering/oxocarbon.nvim" },
  catppuccin = {
    "catppuccin/nvim",
    opts = {
      transparent_background = JSConfig.transparent,
    }
  },
  rosepine = { "rose-pine/neovim" },
  nord = { "shaunsingh/nord.nvim", },
  nordic = {
    "alexvzyl/nordic.nvim",
    config = function()
      require("nordic").load()
    end,
  },
  nightfly = { "bluz71/vim-nightfly-colors", },
}


vim.g.nord_disable_background = not JSConfig.transparent
vim.g.nightflyTransparent = JSConfig.transparent

local M = {}

for n, v in pairs(colorschemes) do
  v["name"] = n
  if n == JSConfig.colorscheme then
    v["priority"] = 1000
    if v.config ~= nil and type(v.config) == "function" then
      v["config"] = function(...)
        v.config(table.unpack(...))
        -- Transparency
        if JSConfig.transparent == true then
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end
      end
    else
      v["config"] = function()
        vim.cmd.colorscheme(n)
        if JSConfig.transparent == true then
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end
      end
    end
  else
    v["event"] = "VeryLazy"
    if v.config ~= nil and type(v.config) == "function" then
      v["config"] = nil
    end
  end
  table.insert(M, v)
end

return M
