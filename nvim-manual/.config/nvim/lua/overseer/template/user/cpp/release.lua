return {
	name = "C++ Release",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "clang++" },
			args = { "-O3", file, "-o", "bin.out" },
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
