return {
	name = "Compile C++",
	params = {
		compiler = {
			name = "Compiler to use",
			type = "string",
			default = "clang++",
		},
		std = {
			name = "C++ standard to be used",
			type = "string",
			optional = true,
		},
		optimize = {
			name = "Optimization level",
			type = "integer",
			validate = function(value)
				if value < 0 or value > 3 then
					return false
				else
					return true
				end
			end,
			optional = true
		},
		debug = {
			name = "Include debug symbols",
			type = "boolean",
			optional = true,
		},
		extra_flags = {
			name = "Extra arguments",
			type = "list",
			subtype = { type = "string" },
			delimiter = ",",
			optional = true,
		},
		impl_files = {
			name = "Implementation Files",
			type = "list",
			subtype = { type = "string" },
			delimiter = ",",
			default = vim.fn.expand("%")
		},
		ofile_name = {
			name = "Output file name",
			type = "string",
			default = "bin.out",
		},
	},
	builder = function(params)
		local args = {}
		if params.std then
			table.insert(args, "-std=" .. params.std)
		end
		if params.optimize then
			table.insert(args, "-O" .. params.optimize)
		end
		if params.debug then
			table.insert(args, "-g")
		end
		if params.extra_flags then
			table.insert(args, params.extra_flags)
		end
		if params.impl_files then
			table.insert(args, params.impl_files)
		end
		if params.ofile_name then
			table.insert(args, "-o" .. params.ofile_name)
		end
		return {
			cmd = params.compiler,
			args = args,
			components = { { "on_output_quickfix", open = false }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
