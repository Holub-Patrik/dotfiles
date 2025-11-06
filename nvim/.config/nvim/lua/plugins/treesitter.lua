local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local tree = require("nvim-treesitter")
		local installed = tree.get_installed()
		local required_langs = { "c", "cpp", "lua", "markdown", "markdown_inline" }

		local function contains(haystack, needle)
			local found = false
			for _, hay in ipairs(haystack) do
				if hay == needle then
					found = true
					break
				end
			end
			return found
		end

		for _, lang in ipairs(required_langs) do
			if not contains(installed, lang) then
				tree.install(lang)
			end
		end

		installed = tree.get_installed()

		for _, lang in ipairs(installed) do
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { lang },
				callback = function()
					-- start treesitter
					vim.treesitter.start()

					-- enable treesitter based folding
					-- vim.o.foldtext = require("configs.foldtext")
					vim.o.foldenable = true
					vim.o.foldlevel = 99
					vim.o.foldlevelstart = 99
					vim.o.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end
	end,
}

return M
