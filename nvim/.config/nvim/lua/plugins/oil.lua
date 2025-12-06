return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		local oil = require("oil")
		oil.setup({
			float = {
				max_width = 0.5,
				max_height = 0.5,
				padding = 0,
				border = 'rounded',
			}
		})
		vim.keymap.set("n", "<leader>o", oil.toggle_float, { desc = "Open File View" })
	end
}
