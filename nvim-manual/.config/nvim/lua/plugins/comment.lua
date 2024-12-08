return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = {
				line = "<leader>/",
				block = "<leader>{",
			},
			mappings = {
				extra = false,
			},
		})
	end,
}
