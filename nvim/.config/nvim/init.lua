local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.o.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
	return
else
	if vim.version().minor < 12 then
		require("lazy").setup({
			change_detection = { enabled = false },
			spec = {
				{ import = "plugins" },
			},
		})
	else
		vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })
		require('zpack').setup()
	end

	require("options")
	require("mappings")
	require("configs")
end
