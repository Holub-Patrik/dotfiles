return {
	"numToStr/Comment.nvim",
	-- event = "BufEnter", -- useless because of dashboard
	config = function()
		require("Comment").setup({
			toggler = {
				line = "<leader>/",
				block = "<leader>\\",
			},
			opleader = {
				line = "<leader>/",
				block = "<leader>\\",
			},
			mappings = {
				extra = false,
			},
		})
	end,
}
