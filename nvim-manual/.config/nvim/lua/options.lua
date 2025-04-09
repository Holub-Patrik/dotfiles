vim.o.number = true
vim.o.rnu = true
vim.o.wrap = true

vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false

vim.o.signcolumn = "yes"

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = require("configs.foldtext")

vim.o.guifont = "monaspace_neon:h12"

vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function()
		vim.cmd("mkview")
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function()
		vim.cmd("silent! loadview")
	end,
})
