return {
	"lervag/vimtex",
	lazy = "false",
	ft = "tex",
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			options = {
				'--shell-escape'
			}
		}
	end,
}
