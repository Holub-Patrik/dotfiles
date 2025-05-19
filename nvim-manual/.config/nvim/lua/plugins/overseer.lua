local M = {
	"stevearc/overseer.nvim",
	config = function()
		local wk = require("which-key")
		require("overseer").setup({
			templates = {
				"builtin",
				"user.cpp",
			},
			default_template_prompt = "missing",

			vim.keymap.set("n", "<leader>r", "<cmd>:OverseerRun<cr>", { desc = "Overseer run" }),
		})
	end,
}

return M
