local M = {
	"rebelot/kanagawa.nvim",
	lazy = false,
	config = function()
		require("kanagawa").setup({
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
				palette = {
					sumiInk0 = "none",
				},
				theme = {
					wave = {},
					lotus = {},
					dragon = {},
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			theme = "dragon",
			background = {
				dark = "wave",
				light = "lotus",
			},
			overrides = function()
				return {
					-- CursorLine = { bg = "None" },
					Folded = { guibg = "None" },
				}
			end,
		})

		vim.cmd("colorscheme kanagawa")
	end,
}

return M
