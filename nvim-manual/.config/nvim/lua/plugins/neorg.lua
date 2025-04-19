local base_dir = "~/neorg-notes/"

local M = {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	build = ":Neorg sync-parsers",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = base_dir .. "notes",
							school = base_dir .. "school",
						},
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.nvim-cmp"] = {},
			},
		})
	end,
}

return M
