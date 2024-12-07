local M = {
	"rebelot/kanagawa.nvim",
	lazy = false,
	config = function ()
		require('kanagawa').setup({
			compile = true,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { italic = true },
			keywordStyle = {},
			statementStyle = {},
			typeStyle = {},
			transparent = true,
			dimInactive = false,
			terminalColors = true,
			colors = {
				palette = {},
				theme = {
					wave = {},
					lotus = {},
					dragon = {},
					all = {
						ui = {
							bg_gutter = "none"
						}
					}
				},
			},
			theme = "dragon",
			background = {
					dark = "wave",
					light = "lotus"
			},
		})

		vim.cmd("colorscheme kanagawa")
	end
}

return M
