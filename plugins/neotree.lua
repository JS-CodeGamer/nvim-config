return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer Neotree Toggle" },
		{ "<leader>ge", "<cmd>Neotree toggle source=git_status<cr>", desc = "Git explorer" },
		{ "<leader>be", "<cmd>Neotree toggle source=buffers<cr>", desc = "Buffer explorer" },
	},
}
