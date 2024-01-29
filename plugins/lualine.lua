return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = true,
		},
		sections = {
			lualine_x = {
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
				},
			},
			lualine_a = {
				{
					"filename",
					patt = 1,
				},
			},
		},
	},
}
