return {
	"neovim/nvim-lspconfig",
	config = function()
		-- to install jsonls (add to readme!)
		-- $ npm i -g vscode-langservers-extracted
		-- $ uv tool install ty@latest
		vim.lsp.enable({ "ty", "jsonls" })
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end,
}
