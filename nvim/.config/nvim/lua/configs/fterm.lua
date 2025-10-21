vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd.setlocal("nonu nornu")
		vim.cmd.startinsert()
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	callback = function()
		vim.api.nvim_buf_delete(0, {})
	end
})

local M = {}
function M.open_term()
	local buffer = vim.api.nvim_create_buf(false, true)
	local window_width = vim.api.nvim_win_get_width(0)
	local window_height = vim.api.nvim_win_get_height(0)

	local ratio = 0.9
	local complement_ratio = (1 - ratio) / 2

	vim.api.nvim_open_win(buffer, true, {
		relative = "win",
		col = math.floor(complement_ratio * window_width),
		row = math.floor(complement_ratio * window_height),
		width = math.floor(ratio * window_width),
		height = math.floor(ratio * window_height),
		border = "rounded",
	})
	vim.fn.termopen("zsh")
end

return M
