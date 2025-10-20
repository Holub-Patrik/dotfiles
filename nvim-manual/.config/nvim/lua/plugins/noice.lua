local M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
		presets = {
			bottom_search = true,
			command_palette = false,
			long_message_to_split = false,
			inc_rename = true,
			lsp_doc_border = true,
		},
		cmdline = {
			view = "cmdline",
		}
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	}
}

return M;
