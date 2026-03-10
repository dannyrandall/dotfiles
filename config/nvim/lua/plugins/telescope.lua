local hidden_globs = { "!*test*", "!*spec*", "!*mock*" }

local function toggle_hidden(prompt_bufnr)
	local action_state = require("telescope.actions.state")
	local picker = action_state.get_current_picker(prompt_bufnr)
	local prompt = picker:_get_prompt()
	require("telescope.actions").close(prompt_bufnr)
	vim.schedule(function()
		if picker._grep_show_all then
			require("telescope.builtin").live_grep({
				default_text = prompt,
				glob_pattern = hidden_globs,
			})
		else
			local p = require("telescope.builtin").live_grep({
				default_text = prompt,
				additional_args = { "--hidden", "--no-ignore" },
				glob_pattern = {},
			})
		end
		-- stay in normal mode and tag the new picker
		vim.defer_fn(function()
			vim.cmd("stopinsert")
			local new_picker = action_state.get_current_picker(vim.api.nvim_get_current_buf())
			if new_picker then
				new_picker._grep_show_all = not picker._grep_show_all
			end
		end, 50)
	end)
end

local state = require("telescope.state")
local action_state = require("telescope.actions.state")

local slow_scroll = function(prompt_bufnr, direction)
	local previewer = action_state.get_current_picker(prompt_bufnr).previewer
	local status = state.get_status(prompt_bufnr)
	if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
		return
	end
	previewer:scroll_fn(1 * direction)
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-f>"] = "close",
					["<C-t>"] = function(prompt_bufnr)
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd("Neotree show")
					end,
				},
				n = {
					["<C-f>"] = "close",
					["q"] = "close",
					["<C-t>"] = function(prompt_bufnr)
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd("Neotree show")
					end,
					["<C-j>"] = function(bufnr) slow_scroll(bufnr, 1) end,
					["<C-k>"] = function(bufnr) slow_scroll(bufnr, -1) end,
				},
			},
		},
		pickers = {
			live_grep = {
				glob_pattern = hidden_globs,
				mappings = {
					n = {
						["H"] = toggle_hidden,
					},
				},
			},
		},
	},
}
