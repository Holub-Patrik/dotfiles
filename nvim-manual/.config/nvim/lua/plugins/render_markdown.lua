local M = {
	'MeanderingProgrammer/render-markdown.nvim',
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = { lsp = { enabled = true } },
		-- render_modes = true,
		anti_conceal = { enabled = false },
	},
}

return M
