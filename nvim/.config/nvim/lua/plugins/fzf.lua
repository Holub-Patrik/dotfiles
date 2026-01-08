local M = {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({ { "fzf-native", "border-fused" }, winopts = { border = "single" } })
		local builtin = require("fzf-lua")

		vim.keymap.set("n", "ff", builtin.files, { desc = "FzF-Lua Files" })
		vim.keymap.set("n", "fb", builtin.buffers, { desc = "FzF-Lua Buffers" })
		vim.keymap.set("n", "fg", builtin.live_grep, { desc = "FzF-Lua Live Grep" })
	end
}

return M
