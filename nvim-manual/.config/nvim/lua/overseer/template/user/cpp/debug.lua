return {
	name = "C++ Debug",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "clang++" },
			args = { "-g", file, "-o", "bin.dbg" },
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
