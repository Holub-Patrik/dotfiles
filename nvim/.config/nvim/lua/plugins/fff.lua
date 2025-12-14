local M = {
	-- very fast file picker, but only for files
	{
		'dmtrKovalenko/fff.nvim',
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		opts = {
			prompt = "> ",
			debug = {
				enabled = false,
				show_scores = false,
			},
		},
		-- No need to lazy-load with lazy.nvim.
		-- This plugin initializes itself lazily.
		lazy = false,
		keys = {
			{
				"ff",
				function() require('fff').find_files() end,
				desc = 'FFFind files',
			},
			{
				"fG",
				function() require('fff').find_in_git_root() end,
				desc = 'FFFind files using git',
			}
		}
	},
	-- slower more general picker, can be used for more difficult choices
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({ { "fzf-native", "border-fused" }, winopts = { border = "single" } })
			local builtin = require("fzf-lua")

			-- fallback if I want to, but for files, fff is much faster
			vim.keymap.set("n", "fzf", builtin.files, { desc = "FzF-Lua Files" })
			vim.keymap.set("n", "fb", builtin.buffers, { desc = "FzF-Lua Buffers" })
			vim.keymap.set("n", "fg", builtin.live_grep, { desc = "FzF-Lua Live Grep" })
		end
	}
}

return M
