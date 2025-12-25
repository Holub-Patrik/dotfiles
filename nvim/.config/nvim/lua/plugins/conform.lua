return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			c = { "clangd" },
			cpp = { "clangd" },
			odin = { lsp_format = "prefer" },
			-- php-cs-fixer is slow on "larger files"
			php = { "php_cs_fixer", timeout_ms = 2500 },
			typst = { "prettypst" },
			tex = { "tex-fmt" },
			latex = { "tex-fmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {},
	},
}
