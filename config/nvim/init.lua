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

vim.keymap.set("", "<C-t>", "<Cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<C-p>", function()
	local winid = vim.fn.getloclist(0, { winid = 0 }).winid
	if winid ~= 0 then
		vim.cmd("lclose")
	else
		vim.diagnostic.setloclist()
	end
end)
vim.keymap.set("n", "<C-g>", "<Cmd>Neotree git_status toggle<CR>")
vim.keymap.set("", "<C-f>", "<Cmd>Telescope live_grep<CR>")

-- lsp keymaps (matching old coc bindings)
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
vim.keymap.set("n", "rn", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "gu", "<C-o>", { silent = true })

-- splits with direction
vim.keymap.set("n", "sh", "<Cmd>set nosplitright | vsplit | set splitright<CR>", { silent = true })
vim.keymap.set("n", "sl", "<Cmd>vsplit<CR>", { silent = true })
vim.keymap.set("n", "sj", "<Cmd>split<CR>", { silent = true })
vim.keymap.set("n", "sk", "<Cmd>set nosplitbelow | split | set splitbelow | wincmd k<CR>", { silent = true })
