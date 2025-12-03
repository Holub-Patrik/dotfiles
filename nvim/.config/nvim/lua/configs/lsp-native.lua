vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.opt.completeopt = { "fuzzy", "menu", "menuone", "noinsert", "popup" }

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
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

local ascii_trigger_chars = {}
for i = 32, 126 do
	table.insert(ascii_trigger_chars, string.char(i))
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local buf = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
		end

		local server_triggers = client.server_capabilities.completionProvider.triggerCharacters
		local joint = vim.tbl_extend("keep", ascii_trigger_chars, server_triggers)

		client.server_capabilities.completionProvider.triggerCharacters = joint
		-- vim.print(client.server_capabilities.completionProvider.triggerCharacters)

		vim.lsp.completion.enable(true, client.id, args.buf, {
			autotrigger = true,
			convert = function(item)
				return { abbr = item.label:gsub("%b()", "") }
			end,
		})

		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end

		map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
		map("n", "<leader>lr", vim.lsp.buf.references, "References")
		map("n", "<leader>lc", vim.lsp.buf.code_action, "Code Actions")
		map({ "n", "x" }, "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, "Format")

		map("n", "gd", vim.lsp.buf.definition, "Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Implementation")
		map("n", "go", vim.lsp.buf.type_definition, "Type definition")
		map("n", "gs", vim.lsp.buf.signature_help, "Signature Help")
		map("n", "gl", vim.diagnostic.open_float, "Diagnostic Float")
		map("n", "<F2>", vim.lsp.buf.rename, "Lsp Rename")

		map("n", "]e", function()
			vim.diagnostic.jump({ count = 1 })
		end, "Next Diagnostic")
		map("n", "[e", function()
			vim.diagnostic.jump({ count = -1 })
		end, "Prev Diagnostic")
	end,
})

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}
vim.lsp.enable("lua_ls")

vim.lsp.config["zls"] = {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
	settings = {
		zls = {
			enable_build_on_save = true,
			build_on_save_step = "install",
			warn_style = false,
			enable_snippets = true,
		},
	},
}
vim.lsp.enable("zls")

vim.lsp.config["clangd"] = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--cross-file-rename",
		"--header-insertion=never",
		-- "--completion-style=detailed",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", ".clangd", "configure.ac", "Makefile", ".git" },
	init_options = {
		fallbackFlags = { "-std=c23" },
	},
}
vim.lsp.enable("clangd")

vim.lsp.config["basedpyright"] = {
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			analysis = {
				typeCheckingMode = "standard",
			},
		},
	},
}
vim.lsp.enable("basedpyright")

vim.lsp.config["phpactor"] = {
	root_dir = nil,
	root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
}
vim.lsp.enable("phpactor")

vim.filetype.add({
	extension = {
		h = "c",
	},
})

local ensured_servers = {
	"lua_ls",
	"ols",
	"rust_analyzer",
	"clangd",
	"ruff",
	"basedpyright",
	"gopls",
}

vim.lsp.enable(ensured_servers)
