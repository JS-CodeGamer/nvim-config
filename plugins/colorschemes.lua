local colorschemes = {
	kanagawa = { "rebelot/kanagawa.nvim", opts = { background = { dark = "dragon" } } },
	oxocarbon = { "nyoom-engineering/oxocarbon.nvim" },
	catppuccin = { "catppuccin/nvim" },
	rosepine = { "rose-pine/neovim" },
	nord = { "shaunsingh/nord.nvim" },
	nordic = {
		"alexvzyl/nordic.nvim",
		config = function(load)
			if load then
				return function()
					require("nordic").load()
				end
			end
		end,
	},
	nightfly = { "bluz71/vim-nightfly-colors" },
}

local M = {}

for n, v in pairs(colorschemes) do
	v["name"] = n
	if n == Colorscheme then
		v["priority"] = 1000
		if v.config ~= nil and type(v.config) == "function" then
			v["config"] = v.config(true)
		else
			v["config"] = function()
				vim.cmd.colorscheme(n)
			end
		end
	else
		v["event"] = "VeryLazy"
		if v.config ~= nil and type(v.config) == "function" then
			v["config"] = v.config(false)
		end
	end
	table.insert(M, v)
end

return M
