local builtin = require("telescope.builtin")
local oil = require("oil")
local term = require("configs.fterm")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

vim.keymap.set("n", "<leader>cc", "<cmd>update<cr><cmd>VimtexCompile<cr>")

vim.keymap.set("n", "<leader>ft", oil.toggle_float, {})
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", "<leader>x", "a<esc><cr>", {})
vim.keymap.set("n", "<leader>c", "a󰄬<esc><cr>", {})
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ot", function()
	term.open_term()
end, {})
