local M = {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup({
			strategy = "jobstart",
			templates = {
				"builtin",
				"user.c",
				"user.cpp",
				"user.perf"
			},
			default_template_prompt = "missing",
		})
		vim.keymap.set("n", "<leader>r", "<cmd>:OverseerRun<cr>", { desc = "Overseer run" })

		vim.api.nvim_create_user_command("OverseerRestartLast", function()
			local overseer = require("overseer")
			local tasks = overseer.list_tasks({ recent_first = true })
			if vim.tbl_isempty(tasks) then
				vim.notify("No tasks found", vim.log.levels.WARN)
			else
				overseer.run_action(tasks[1], "restart")
			end
		end, {})
	end,
}

return M
