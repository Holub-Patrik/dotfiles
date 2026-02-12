local function should_handle_folds(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end
	local ft = vim.bo[bufnr].filetype
	local bt = vim.bo[bufnr].buftype
	if ft == "" or bt ~= "" then
		return false
	end

	-- Use the new nvim-treesitter API if available
	local ok, ts = pcall(require, "nvim-treesitter")
	if ok and ts.get_installed then
		local installed = ts.get_installed()
		for _, lang in ipairs(installed) do
			if lang == ft then
				return true
			end
		end
	end

	return false
end

local function get_view_dir(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname == "" then
		return nil
	end

	local res = vim.fs.find(".nvim/view", {
		upward = true,
		path = vim.fs.dirname(bufname),
		stop = vim.uv.os_homedir(),
	})
	return res[1]
end

vim.opt.viewoptions = { "folds", "cursor", "curdir", "localoptions" }

local group = vim.api.nvim_create_augroup("FoldsManager", { clear = true })

local function manage_view(op, bufnr)
	if not should_handle_folds(bufnr) then
		return
	end

	local view_dir = get_view_dir(bufnr)
	local old_viewdir = vim.o.viewdir

	if view_dir then
		vim.o.viewdir = view_dir
	end

	if op == "save" then
		vim.cmd.mkview()
	else
		-- loadview can fail if the view file doesn't exist yet
		pcall(vim.cmd.loadview)
	end

	vim.o.viewdir = old_viewdir
end

vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost" }, {
	group = group,
	callback = function(args)
		manage_view("save", args.buf)
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = group,
	callback = function(args)
		vim.schedule(function()
			manage_view("load", args.buf)
		end)
	end,
})

