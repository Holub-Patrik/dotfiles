local M = {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup({
			templates = {
				"builtin",
				"user.cpp",
			},
			default_template_prompt = "missing",

			vim.keymap.set("n", "<leader>r", "<cmd>:OverseerRun<cr>", {}),
		})
	end,
}

return M
