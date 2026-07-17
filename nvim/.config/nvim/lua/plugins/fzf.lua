local fff = {
	'dmtrKovalenko/fff.nvim',
	config = function()
		vim.api.nvim_create_autocmd('PackChanged', {
			callback = function(ev)
				local name, kind = ev.data.spec.name, ev.data.kind
				if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
					if not ev.data.active then vim.cmd.packadd('fff.nvim') end
					require('fff.download').download_or_build_binary()
				end
			end,
		})

		vim.g.fff = {
			lazy_sync = true,
			debug = { enabled = false, show_scores = true },
		}

		vim.keymap.set('n', 'ff', require('fff').find_files, { desc = 'FFFind files' })
		vim.keymap.set('n', 'fg', require('fff').live_grep, { desc = 'FFFind word (grep)' })
		vim.keymap.set('n', 'fc', require('fff').live_grep_under_cursor, { desc = 'FFFind word under cursor' })
	end
}

local fzf = {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({ { "fzf-native", "border-fused" }, winopts = { border = "single" } })
		local builtin = require("fzf-lua")

		vim.keymap.set("n", "ff", builtin.files, { desc = "FzF-Lua Files" })
		vim.keymap.set("n", "fF", builtin.git_files, { desc = "FzF-Lua Git Files" })
		vim.keymap.set("n", "fb", builtin.buffers, { desc = "FzF-Lua Buffers" })
		vim.keymap.set("n", "fg", builtin.live_grep, { desc = "FzF-Lua Live Grep" })
	end
}


return fff
