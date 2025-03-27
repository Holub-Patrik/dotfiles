local M = {
	-- Calls `require('slimline').setup({})`
	"sschleemilch/slimline.nvim",
	opts = {
		style = "fg",
	},
	config = function(_, opts)
		require("slimline").setup(opts)
	end,
}

return M
