local builtin = require("telescope.builtin")
local oil = require("oil")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

vim.keymap.set("n", "<leader>cc", "<cmd>update<cr><cmd>VimtexCompile<cr>")

vim.keymap.set("n", "<leader>ft", oil.toggle_float, {})
