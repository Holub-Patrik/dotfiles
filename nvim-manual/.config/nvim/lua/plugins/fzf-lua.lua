local M = {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local builtin = require("fzf-lua")
		builtin.register_ui_select()

		vim.keymap.set("n", "<leader>ff", builtin.files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep search" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fG", builtin.git_files, { desc = "Find files using git" })
	end
}

return M
