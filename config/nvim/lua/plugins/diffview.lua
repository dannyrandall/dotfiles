-- close the diffview tab and open `path` in the tab we came from, optionally
-- restoring the cursor to `cursor` ({ line, col } as returned by nvim_win_get_cursor)
local function close_and_edit(path, cursor)
	if vim.fn.filereadable(path) == 0 then
		vim.notify("File does not exist on disk: " .. path, vim.log.levels.WARN)
		return
	end

	vim.cmd("DiffviewClose")
	vim.cmd("edit " .. vim.fn.fnameescape(path))
	if cursor then
		pcall(vim.api.nvim_win_set_cursor, 0, cursor)
	end
end

return {
	"sindrets/diffview.nvim",
	opts = {
		keymaps = {
			view = {
				-- close diffview and open the file at the current line
				{ "n", "<cr>", function()
					close_and_edit(vim.fn.expand("%:p"), { vim.fn.line("."), vim.fn.col(".") - 1 })
				end },
				{ "n", "<C-f>", "<Cmd>Telescope live_grep<CR>" },
			},
			file_panel = {
				-- <cr> on a file opens its diff; <cr> again on the already-open
				-- file closes diffview and opens it in the tab we came from
				{ "n", "<cr>", function()
					local view = require("diffview.lib").get_current_view()
					if not view or not view.panel then return end

					local item = view.panel:get_item_at_cursor()
					if not item then return end

					-- directory entry: fold/unfold as usual
					if type(item.collapsed) == "boolean" then
						view.panel:toggle_item_fold(item)
						return
					end

					if item ~= view.panel.cur_file then
						view:set_file(item, false)
						return
					end

					-- already open in the diff view: carry its cursor over
					local cursor
					local win = view.cur_layout and view.cur_layout:get_main_win()
					if win and win.id and vim.api.nvim_win_is_valid(win.id) then
						cursor = vim.api.nvim_win_get_cursor(win.id)
					end

					close_and_edit(item.absolute_path, cursor)
				end },
				{ "n", "<C-f>", "<Cmd>Telescope live_grep<CR>" },
			},
		},
	},
}
