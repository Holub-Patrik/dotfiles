return {
	name = "C++ 23 Build",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "clang++" },
			args = { "-std=c++23", file, "-o", "bin.out" },
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
