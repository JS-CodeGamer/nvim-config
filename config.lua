-- set neovim options
require("js.options")

-- get colorscheme
-- local colorscheme = require("js.colorscheme")("nightfly")

-- install lazy.nvim plugin manager if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

Colorscheme = "nordic"

require("lazy").setup({
  spec = {
    { import = "js.plugins" },
    -- have lazy manage itself
    "fole/lazy.nvim",
  },
  checker = { enabled = true },
  performance = { rtp = { disabled_plugins = { "netrwPlugin" } } },
  default = {
    version = "*",
  },
})
