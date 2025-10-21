local theme = require("kanagawa.colors").setup({ transparent = true }).theme

local set_colors = function(definition)
	for hl, col in pairs(definition) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

set_colors({
	TelescopeTitle = { fg = theme.ui.special, bold = true },
	TelescopePromptNormal = { bg = theme.ui.bg_p1 },
	TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
	TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
	TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
	TelescopePreviewNormal = { bg = theme.ui.bg_dim },
	TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
})

set_colors({
	NormalFloat = { bg = "none" },
	FloatBorder = { bg = "none" },
	FloatTitle = { bg = "none" },

	NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
	LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
	MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
})

set_colors({
	Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
	PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
	PmenuSbar = { bg = theme.ui.bg_m1 },
	PmenuThumb = { bg = theme.ui.bg_p2 },
})
