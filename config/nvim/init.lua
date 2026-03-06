require("config.lazy")

-- tabs
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.cmd("filetype plugin indent on")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "javascript" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldnestmax = 4
vim.opt.foldlevelstart = 99

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- show line numbers
vim.opt.number = true

-- lsp floating window borders
vim.diagnostic.config({ float = { border = "rounded" } })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", pad_top = 1, pad_bottom = 1 })

-- remap escape
vim.keymap.set("v", "fd", "<Esc>", { noremap = true })
vim.keymap.set("i", "fd", "<Esc>", { noremap = true })

-- close hover float with K
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(ev)
		if vim.bo[ev.buf].buftype == "nofile" then
			vim.keymap.set("n", "K", "<Cmd>close<CR>", { buffer = ev.buf })
		end
	end,
})

-- easier window movement
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", {noremap = true})
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", {noremap = true})
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", {noremap = true})
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", {noremap = true})

vim.keymap.set("", "<C-t>", function()
	local lib = require("diffview.lib")
	if lib.get_current_view() then
		vim.cmd("DiffviewClose")
		vim.cmd("Neotree show")
	else
		vim.cmd("Neotree toggle")
	end
end)
vim.keymap.set("n", "<C-p>", function()
	local winid = vim.fn.getloclist(0, { winid = 0 }).winid
	if winid ~= 0 then
		vim.cmd("lclose")
	else
		vim.diagnostic.setloclist()
	end
end)
-- diffview: open / focus file tree / close
vim.keymap.set("n", "<C-g>", function()
	local lib = require("diffview.lib")
	local view = lib.get_current_view()
	if not view then
		vim.cmd("DiffviewOpen")
	elseif vim.bo.filetype == "DiffviewFiles" then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewFocusFiles")
	end
end)
vim.keymap.set("n", "<C-y>", function()
	local lib = require("diffview.lib")
	if lib.get_current_view() then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewFileHistory %")
	end
end)
vim.keymap.set("", "<C-f>", "<Cmd>Telescope live_grep<CR>")

-- lsp keymaps (matching old coc bindings)
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "gu", "<Cmd>execute 'normal!' \"\\<C-o>\"<CR>", { silent = true })
-- open file URL on remote (code.amazon.com / github)
local function open_git_url(range)
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	local line_anchor
	if range then
		local start_line = vim.fn.line("'<")
		local end_line = vim.fn.line("'>")
		line_anchor = "#L" .. start_line .. "-L" .. end_line
	else
		line_anchor = "#L" .. line
	end
	local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))
	local remote = vim.fn.system("git -C " .. dir .. " remote get-url origin 2>/dev/null"):gsub("%s+$", "")
	if remote == "" then return vim.notify("No git remote found", vim.log.levels.WARN) end

	local rel = vim.fn.system("git -C " .. dir .. " ls-files --full-name " .. vim.fn.shellescape(file)):gsub("%s+$", "")

	-- get upstream ref (e.g. "share/feat/user-skills") and extract remote name + branch
	local upstream = vim.fn.system("git -C " .. dir .. " rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null"):gsub("%s+$", "")
	local remote_name, branch
	if upstream ~= "" then
		remote_name = upstream:match("^([^/]+)/")
		branch = upstream:match("^[^/]+/(.+)$")
	end
	if not remote_name then
		remote_name = "origin"
		branch = vim.fn.system("git -C " .. dir .. " rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("%s+$", "")
	end

	-- get the actual remote URL for the upstream remote
	local upstream_remote = vim.fn.system("git -C " .. dir .. " remote get-url " .. remote_name .. " 2>/dev/null"):gsub("%s+$", "")
	if upstream_remote ~= "" then remote = upstream_remote end

	local url
	if remote:find("git.amazon.com") then
		local repo = remote:match("/pkg/([^/]+)")
		-- extract suffix after /pkg/RepoName (e.g. "/share/dnrnd")
		local suffix = remote:match("/pkg/[^/]+(/.+)$") or ""
		url = ("https://code.amazon.com/packages/%s/blobs%s/%s/--/%s%s"):format(repo, suffix, branch, rel, line_anchor)
	elseif remote:find("github.com") then
		local path = remote:gsub("^git@github%.com:", ""):gsub("^https?://github%.com/", ""):gsub("%.git$", "")
		url = ("https://github.com/%s/blob/%s/%s%s"):format(path, branch, rel, line_anchor)
	else
		return vim.notify("Unknown remote: " .. remote, vim.log.levels.WARN)
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { url })
	local width = #url + 2
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "cursor", row = 1, col = 0,
		width = width, height = 1,
		style = "minimal", border = "rounded",
	})
	vim.bo[buf].modifiable = false
	vim.keymap.set("n", "<Esc>", function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
	vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
	vim.keymap.set("n", "<C-o>", function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
end
vim.keymap.set("n", "<C-o>", function() open_git_url(false) end)
vim.keymap.set("v", "<C-o>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
	open_git_url(true)
end)

-- splits with direction
vim.keymap.set("n", "sh", "<Cmd>set nosplitright | vsplit | set splitright<CR>", { silent = true })
vim.keymap.set("n", "sl", "<Cmd>vsplit<CR>", { silent = true })
vim.keymap.set("n", "sj", "<Cmd>split<CR>", { silent = true })
vim.keymap.set("n", "sk", "<Cmd>set nosplitbelow | split | set splitbelow | wincmd k<CR>", { silent = true })
