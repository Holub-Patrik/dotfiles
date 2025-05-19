local builtin = require("telescope.builtin")
local oil = require("oil")
local term = require("configs.fterm")

function vim.find_files_from_project_git_root()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")
		return vim.v.shell_error == 0
	end
	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end
	local opts = {}
	if is_git_repo() then
		opts.cwd = get_git_root()
	end
	opts.hidden = true
	require("telescope.builtin").find_files(opts)
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep search" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fG", vim.find_files_from_project_git_root, { desc = "Find files using git" })

vim.keymap.set("n", "<leader>cc", "<cmd>update<cr><cmd>VimtexCompile<cr>", { desc = "Compile tex file" })

vim.keymap.set("n", "<leader>ft", oil.toggle_float, { desc = "Open file tree" })
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", "<leader><leader>x", "i<esc>", { desc = "Place an x mark" })
vim.keymap.set("n", "<leader><leader>c", "i󰄬<esc>", { desc = "Place a check mark" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ot", function()
	term.open_term()
end, { desc = "Open floating terminal" })

vim.api.nvim_create_autocmd(
	"FileType", {
		pattern = { "qf" },
		callback = function()
			vim.keymap.set("n", "<CR>", "<CR>:ccl<CR>", { noremap = true, buffer = true, silent = true })
		end
	}
)
