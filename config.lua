-- set neovim options
require("js.options")

-- install lazy.nvim plugin manager if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

JSConfig = {
  colorscheme = "catppuccin",
  transparent = true
}

require("lazy").setup({
  spec = {
    { import = "js.plugins" },
    -- have lazy manage itself
    { "folke/lazy.nvim",    version = false },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
