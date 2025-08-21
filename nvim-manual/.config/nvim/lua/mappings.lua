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

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function()
		vim.keymap.set("n", "<CR>", "<CR>:ccl<CR>", { noremap = true, buffer = true, silent = true })
	end,
})
