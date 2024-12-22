local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

vim.keymap.set("n", "<leader>dc", dap.continue, {})
vim.keymap.set("n", "<leader>do", dap.step_over, {})
vim.keymap.set("n", "<leader>di", dap.step_into, {})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<leader>dr", dap.repl.open, {})
vim.keymap.set("n", "<leader>dl", dap.run_last, {})

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "/usr/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			local file
			vim.ui.input({
				prompt = "Path to executable: " .. vim.fn.getcwd() .. "/",
			}, function(str)
				file = vim.fn.getcwd() .. "/" .. str
			end)
			return file
		end,
		args = function()
			local args
			vim.ui.input({
				prompt = "Arguments to use: ",
			}, function(str)
				args = vim.split(str, " ")
			end)
			return args
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
