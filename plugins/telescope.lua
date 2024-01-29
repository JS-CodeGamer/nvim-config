return {
	"nvim-telescope/telescope.nvim",
	version = false,
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			enabled = vim.fn.executable("make") == 1,
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	opts = {
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
		},
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{
			"<leader>fr",
			"<cmd>Telescope oldfiles<cr>",
			desc = "Open Recent File",
			noremap = false,
		},
		{ "<leader>th", "<cmd>Telescope colorscheme<cr>", desc = "Select Theme" },
	},
}
