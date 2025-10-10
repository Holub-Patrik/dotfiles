-- require("dap-python").setup("uv")
local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open repl" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })

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

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-dap",
	name = "lldb",
}

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "lldb",
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
		initCommands = function()
			-- Find out where to look for the pretty printer Python module.
			local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
			assert(
				vim.v.shell_error == 0,
				"failed to get rust sysroot using `rustc --print sysroot`: " .. rustc_sysroot
			)
			local script_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_lookup.py"
			local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

			return {
				([[!command script import '%s']]):format(script_file),
				([[command source '%s']]):format(commands_file),
			}
		end,
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "lldb",
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
