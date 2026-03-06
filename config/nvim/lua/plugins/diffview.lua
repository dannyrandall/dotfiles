return {
	"sindrets/diffview.nvim",
	opts = {
		keymaps = {
			view = {
				-- close diffview and open the file at the current line
				{ "n", "<cr>", function()
					local file = vim.fn.expand("%:p")
					local line = vim.fn.line(".")
					local col = vim.fn.col(".")
					vim.cmd("DiffviewClose")
					vim.cmd("edit " .. vim.fn.fnameescape(file))
					vim.api.nvim_win_set_cursor(0, { line, col - 1 })
				end },
			},
		},
	},
}
