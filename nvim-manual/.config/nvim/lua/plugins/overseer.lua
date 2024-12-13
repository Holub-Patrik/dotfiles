local M = {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup({
			templates = {
				"builtin",
				"user.cpp",
			},

			vim.keymap.set("n", "<leader>r", "<cmd>:OverseerRun<cr>", {}),
		})
	end,
}

return M
