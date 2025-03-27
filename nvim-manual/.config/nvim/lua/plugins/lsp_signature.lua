local M = {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	---@module "lsp_signature"
	opts = {
		floating_window = true,
		transparency = 100,
		select_signature_key = "<C-n>",
		hint_enable = false,
		hint_prefix = "",
		extra_trigger_chars = { "(", "," },
		hint_inline = function()
			return true
		end,
		timer_interval = 0,
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}

return M
