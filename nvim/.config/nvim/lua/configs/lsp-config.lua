local ensured_servers = {
	"lua_ls",
	"ols",
	"rust_analyzer",
	"clangd",
	"ruff",
	-- "basedpyright",
	"ty",
	"gopls",
}

require("mason-lspconfig").setup({
	ensure_installed = ensured_servers,
	automatic_enable = true,
})

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
	},
})

-- vim.lsp.config("basedpyright", {
-- 	settings = {
-- 		basedpyright = {
-- 			disableOrganizeImports = true,
-- 			analysis = {
-- 				typeCheckingMode = "standard",
-- 			},
-- 		},
-- 	},
-- })

vim.lsp.config("phpactor", {
	root_dir = nil,
	root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
})

local orig = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	opts.max_width = opts.max_width or 80
	opts.max_height = opts.max_height or 24
	opts.wrap = opts.wrap ~= false
	return orig(contents, syntax, opts, ...)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Lsp Actions",
	callback = function()
		local map = function(mode, lhs, rhs, desc)
			local opts = { buffer = true, desc = desc }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		map("n", "<leader>lh", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "Hover")
		map("n", "gd", vim.lsp.buf.definition, "Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Implementation")
		map("n", "go", vim.lsp.buf.type_definition, "Type definition")
		map("n", "<leader>lr", vim.lsp.buf.references, "References")
		map("n", "<leader>lH", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, "Signature help")
		-- bufmap("n", "<F2>", lsp_rename, { desc = "Rename" })
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>eh", vim.diagnostic.open_float, "Open float")
		map("n", "]e", function()
			vim.diagnostic.jump({ count = 1 })
		end, "Goto next error")
		map("n", "[e", function()
			vim.diagnostic.jump({ count = -1 })
		end, "Goto prev error")
	end,
})
