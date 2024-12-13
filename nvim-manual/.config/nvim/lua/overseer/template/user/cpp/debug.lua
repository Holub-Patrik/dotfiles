return {
	name = "C++ Debug File",
	params = {
		std = {
			name = "C++ standard to be used",
			type = "string",
			default = "-std=c++23",
			optional = true,
		},
		extra_flags = {
			name = "Extra arguments",
			desc = "Argument list given will be passed after std and before -g and file",
			type = "list",
			subtype = {
				type = "string",
			},
			delimiter = ",",
			optional = true,
		},
		impl_files = {
			name = "Implementation Files",
			desc = "Extra implementation files list to be used for simple project",
			type = "list",
			subtype = "string",
			delimiter = ",",
			optional = true,
		},
		ofile_name = {
			name = "Output file name",
			desc = "How should be the file named. If no name given -o param won't be passed",
			type = "string",
			default = "bin.out",
			optional = true,
		},
	},
	builder = function(params)
		local file = vim.fn.expand("%:p")
		local args = {}
		if params.std then
			table.insert(args, params.std)
		end
		if params.extra_flags then
			table.insert(args, params.extra_flags)
		end
		table.insert(args, file)
		if params.impl_files then
			table.insert(args, params.impl_files)
		end
		if params.ofile_name then
			table.insert(args, "-o")
			table.insert(args, params.ofile_name)
		end
		return {
			cmd = { "clang++" },
			args = args,
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
