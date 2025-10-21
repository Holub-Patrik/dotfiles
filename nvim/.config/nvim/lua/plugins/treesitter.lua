local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local config = require("nvim-treesitter.configs")

		config.setup({
			ensure_installed = { "lua", "odin", "rust", "c" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}

return M
