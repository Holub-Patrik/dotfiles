local ensured_servers = { "lua_ls", "ols", "rust_analyzer", "clangd", "ruff", "pyright" }
local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local mason_lsp_config = require("mason-lspconfig")
local lsp_config = require("lspconfig")

mason_lsp_config.setup({
	ensure_installed = ensured_servers,
})

mason_lsp_config.setup_handlers({
	function(server)
		lsp_config[server].setup({
			capabilities = cmp_caps,
		})
	end,
	["clangd"] = function()
		lsp_config.clangd.setup({
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--cross-file-rename",
				"--header-insertion=iwyu",
			},
			capabilities = cmp_caps,
		})
	end,
	["pyright"] = function()
		lsp_config.pyright.setup({
			settings = {
				pyright = {
					disablleOrganizeImports = true,
				},
				python = {
					ignore = { "*" },
				},
			},
		})
	end,
	["hls"] = function() end,
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
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "<leader>lh", '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<cr>')
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
		bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>")
		bufmap("n", "<leader>lH", '<cmd>lua vim.lsp.buf.signature_help({border = "rounded"})<cr>')
		-- bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<F2>", "<cmd>lua require('renamer').rename()<cr>")
		bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("n", "<leader>eh", "<cmd>lua vim.diagnostic.open_float()<cr>")
		bufmap("n", "]e", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		bufmap("n", "[e", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local luasnip = require("luasnip")

local select_opts = { behavior = cmp.SelectBehavior.Select }
local rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

-- limit menu height
vim.o.pumheight = 15
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "buffer",   keyword_length = 3 },
		{ name = "luasnip",  keyword_length = 2 },
	},
	window = {
		completion = cmp.config.window.bordered({ border = rounded }),
		documentation = cmp.config.window.bordered({ border = rounded }),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		expandable_indicator = true,
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
			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-esc>"] = cmp.mapping.abort(),
	},
})
