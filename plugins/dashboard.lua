-- return {
-- 	"nvimdev/dashboard-nvim",
-- 	event = "VimEnter",
-- 	opts = {
-- 		theme = "hyper",
-- 		config = {
--       -- stylua: ignore
-- 			shortcut = {
-- 				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
-- 				{ desc = " Files", group = "Label", action = 'Telescope find_files', key = "f" },
-- 				{ desc = " Apps", group = "DiagnosticHint", action = "Telescope app", key = "a" },
-- 				{ desc = " dotfiles", group = "Number", action = "Telescope dotfiles", key = "d" },
-- 			},
-- 		},
-- 	},
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- }

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = {
		theme = "doom",
		hide = {
			statusline = false,
		},
		config = {
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
          -- { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = "CompetiTest receive problem",                              desc = " CP Receive",      icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
			footer = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
			end,
		},
	},
}
