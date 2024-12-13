return {
	name = "C++ 23 Debug",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "clang++" },
			args = { "-std=c++23", "-g", file, "-o", "bin.dbg" },
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
