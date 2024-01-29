local servers = {
	"lua_ls",
	"pyright",
	"jsonls",
	"tsserver",
	"rust_analyzer",
	"clangd",
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = { "RubixDev/mason-update-all" },
		opts = function()
			require("mason-update-all").setup()
			return {
				ui = {
					border = "none",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			}
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = servers,
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for _, server in pairs(servers) do
				opts = {
					on_attach = require("js.plugins.lsp.handlers").on_attach,
					capabilities = require("js.plugins.lsp.handlers").capabilities,
				}
				local server_name = vim.split(server, "@")[1]
				local require_ok, conf_opts = pcall(require, "js.plugins.lsp.settings." .. server_name)
				if require_ok then
					opts = vim.tbl_deep_extend("force", conf_opts, opts)
				end
				lspconfig[server_name].setup(opts)
			end
			require("js.plugins.lsp.handlers").setup()
		end,
	},
}
