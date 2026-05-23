local term = require("configs.fterm")

-- with addition of which key, the default vimtex commands are simple to access
-- vim.keymap.set("n", "<leader>cc", "<cmd>update<cr><cmd>VimtexCompile<cr>", { desc = "Compile tex file" })

vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", "<leader><leader>x", "i<esc>", { desc = "Place an x mark" })
vim.keymap.set("n", "<leader><leader>c", "i󰄬<esc>", { desc = "Place a check mark" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

-- if I ever add other things to open
-- move this to ot
vim.keymap.set("n", "<leader>t", function()
	term.open_term()
end, { desc = "Open floating terminal" })

vim.keymap.set("n", "<F2>", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function()
		vim.keymap.set("n", "<CR>", "<CR>:ccl<CR>", { noremap = true, buffer = true, silent = true })
	end,
})

vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = "Toggle line comment" })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = "Toggle comment (visual)" })
vim.keymap.set('o', '<leader>/', 'gc', { remap = true, desc = "Comment text object" })

vim.keymap.set('n', '<leader>\\', 'gb', { remap = true, desc = "Block comment operator" })
vim.keymap.set('n', '<leader>\\\\', 'gbc', { remap = true, desc = "Toggle block comment" })
vim.keymap.set('v', '<leader>\\', 'gb', { remap = true, desc = "Toggle block comment (visual)" })
