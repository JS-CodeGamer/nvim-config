local colorschemes = {
	kanagawa = { "rebelot/kanagawa.nvim", opts = { background = { dark = "dragon" } } },
	oxocarbon = { "nyoom-engineering/oxocarbon.nvim" },
	catppuccin = { "catppuccin/nvim" },
	rosepine = { "rose-pine/neovim" },
	nord = { "shaunsingh/nord.nvim" },
	nordic = {
		"alexvzyl/nordic.nvim",
		config = function()
			require("nordic").load()
			vim.cmd.colorscheme("nordic")
		end,
	},
	nightfly = { "bluz71/vim-nightfly-colors" },
}

local M = {}

for n, v in pairs(colorschemes) do
	v["name"] = n
	v["lazy"] = true
	-- if n == style.colorscheme then
	--   v["lazy"] = false
	--   v["priority"] = 1000
	--   vim.tbl_extend("keep", v, style.opts)
	-- end
	-- set colorscheme
	if n == Colorscheme then
		v["lazy"] = false
		v["priority"] = 1000
		v["config"] = v.config or function()
			vim.cmd.colorscheme(n)
		end
	end
	table.insert(M, v)
end

return M
