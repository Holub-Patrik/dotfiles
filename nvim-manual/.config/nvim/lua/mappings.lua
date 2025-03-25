local builtin = require("telescope.builtin")
local oil = require("oil")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

vim.keymap.set("n", "<leader>cc", "<cmd>update<cr><cmd>VimtexCompile<cr>")

vim.keymap.set("n", "<leader>ft", oil.toggle_float, {})
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", "<leader>x", "a<esc><cr>", {})
vim.keymap.set("n", "<leader>c", "a󰄬<esc><cr>", {})
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd([[setlocal nonu nornu]])
		vim.cmd([[startinsert]])
	end,
})

local function create_fterm()
	local buffer = vim.api.nvim_create_buf(false, true)
	local window_width = vim.api.nvim_win_get_width(0)
	local window_height = vim.api.nvim_win_get_height(0)

	local ratio = 0.9
	local complement_ratio = (1 - ratio) / 2

	vim.api.nvim_open_win(buffer, true, {
		relative = "win",
		col = math.floor(complement_ratio * window_width),
		row = math.floor(complement_ratio * window_height),
		width = math.floor(ratio * window_width),
		height = math.floor(ratio * window_height),
		border = "rounded",
	})
	vim.fn.termopen("zsh")
end

vim.keymap.set("n", "<leader>ot", create_fterm, {})
