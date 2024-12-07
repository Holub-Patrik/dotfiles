local servers = { "lua_ls", "ols", "rust_analyzer", "clangd" }
local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

local lsp_config = require("lspconfig")
for _, server in pairs(servers) do
	lsp_config[server].setup({
		capabilities = cmp_caps,
	})
end
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Lsp Actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>")
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
		bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>")
		bufmap("n", "<leader>lH", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("n", "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>")
		bufmap("n", "<leader>le", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		bufmap("n", "<leader>lE", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local luasnip = require("luasnip")

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = ">",
				luasnip = "",
				buffer = "",
				path = "",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<cr>"] = cmp.mapping.confirm({ select = false }),
		["<S-up>"] = cmp.mapping.scroll_docs(-4),
		["<S-down>"] = cmp.mapping.scroll_docs(4),
		["<tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif cmp.visible() then
				cmp.select_next_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-esc>"] = cmp.mapping.abort(),
	},
})
