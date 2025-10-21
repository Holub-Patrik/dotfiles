local M = {
	name = "Run perf record",
	params = {
		call_graph = {
			name = "Backtrace recording method",
			type = "string",
			default = "dwarf",
			validate = function(value)
				if value == "fp" or value == "dwarf" then
					return true
				else
					return false
				end
			end
		},
		frequency = {
			name = "Frequency to sample",
			type = "integer",
			optional = true,
		},
		all_cpus = {
			name = "Multithreading",
			type = "boolean",
			optional = true
		},
		extra_args = {
			name = "Any extra user args",
			type = "list",
			subtype = { type = "string" },
			delimiter = ",",
			optional = true
		},
		binary = {
			name = "Program to record",
			type = "string",
		}
	},
	builder = function(params)
		local args = {}
		table.insert(args, "--call-graph=" .. params.call_graph)
		if params.frequency then
			table.insert(args, "-F")
			table.insert(args, params.frequency)
		end
		if params.all_cpus then
			table.insert(args, "-a")
		end
		if params.extra_args then
			table.insert(args, params.extra_args)
		end
		table.insert(args, params.binary)
		return {
			cmd = { "perf", "record" },
			args = args,
			components = { "default" },
		}
	end
}

return M
