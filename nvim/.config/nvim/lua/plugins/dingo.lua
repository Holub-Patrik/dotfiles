local M = {
	"MadAppGang/dingo.nvim",
	ft = "dingo",
	config = function()
		require("dingo").setup({
			lsp = {
				enabled = true,
				log_level = "info",
			},
			format = {
				enabled = true,
				on_save = true,
			},
			lint = {
				enabled = true,
				on_save = true,
			},
		})
	end,
}

return M
