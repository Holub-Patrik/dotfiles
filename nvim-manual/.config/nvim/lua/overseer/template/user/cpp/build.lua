return {
	name = "C++ Build",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "clang++" },
			args = { file, "-o", "bin.out" },
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
