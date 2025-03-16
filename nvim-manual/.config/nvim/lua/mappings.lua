local builtin = require("telescope.builtin")
local oil = require("oil")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

vim.keymap.set("n", "<leader>cc", "<cmd>update<cr><cmd>VimtexCompile<cr>")

vim.keymap.set("n", "<leader>ft", oil.toggle_float, {})
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", "<leader>x", "a<esc><cr>", {})
vim.keymap.set("n", "<leader>c", "a󰄬<esc><cr>", {})

local function create_fterm()
	local buffer = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_open_win(buffer, true,
		{ relative = 'win', row = 5, col = 5, width = 100, height = 50, border = "rounded" })
	local chan = vim.api.nvim_open_term(buffer, {})
	vim.api.nvim_chan_send(chan, "zsh\n")
end

vim.keymap.set("n", "<leader>ot", create_fterm, {})
