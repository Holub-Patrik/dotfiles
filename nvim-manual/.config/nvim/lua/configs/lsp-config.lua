local ensured_servers = {
	"lua_ls",
	"ols",
	"rust_analyzer",
	"clangd",
	"ruff",
	"basedpyright",
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
		"--cross-file-rename",
		"--header-insertion=iwyu",
	},
})

vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			analysis = {
				typeCheckingMode = "standard",
			},
		},
	},
})

vim.lsp.config("phpactor", {
	root_dir = nil,
	root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
})

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
		local bufmap = function(mode, lhs, rhs, given_opts)
			local opts = { buffer = true }
			vim.tbl_deep_extend("keep", opts, given_opts)
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "<leader>lh", '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>', { desc = "Hover" })
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Definition" })
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Declaration" })
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Implementation" })
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "Type definition" })
		bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "References" })
		bufmap(
			"n",
			"<leader>lH",
			'<cmd>lua vim.lsp.buf.signature_help({border = "rounded"})<cr>',
			{ desc = "Signature help" }
		)
		-- bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<F2>", "<cmd>lua require('renamer').rename()<cr>", { desc = "Rename" })
		bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
		bufmap("n", "<leader>eh", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open float" })
		bufmap("n", "]e", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Goto next error" })
		bufmap("n", "[e", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Goto prev error" })
	end,
})
